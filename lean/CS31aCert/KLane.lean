import CS31aCert.KFast

/-!
# The lane-packed kernel checker (core Lean only, kernel use only)

For one input `(c, l)` the shape of the window table (the lengths of `top` and `bot`, the region loops, the number of
new rows) is the same for every state, so the transitions of all states of a `KTree` leaf are computed in lockstep:
lane `i` (bits `64 i … 64 i + 63` of one `Nat`) carries the masks of entry `i` of the leaf. Every bit operation of
`kstep` becomes one operation on the packed number; after a shift a lane mask keeps bits from crossing into the
neighbouring lane, and the only addition (the carry chain of a line update) never carries out of a lane.

The traceback walks the new rows from the bottom: in each row every lane stops at the highest stop column
(`¬vert ∨ horiz`) at or left of its position and moves up (`¬vert`) or diagonally (`vert ∧ horiz`), so all lanes leave
the row together; row `h` is then checked for a stop between column `h + 1` and the position.

Lookups: `KTree.findL` bisects inside the leaves. The successors of the lanes of a leaf usually share their top `2h` key
bits, so `KTree.fingerL` descends once per input to the deepest subtree whose key range contains all keys with the top
bits of lane 0's successor; lane lookups with these top bits start there. Every entry still checks itself with the
lookup from the root (`findL t k = some u`).

All arithmetic is written with the kernel-accelerated primitives (`Nat.land`, `Nat.shiftRight`, …) and all case
distinctions with the recursors themselves (`Bool.rec`, `Option.rec`), which the kernel reduces in one step.
The functions are `noncomputable`: they are only evaluated by the kernel (`decide +kernel`).
-/

namespace CS31aCert

/-- `List.map` as a recursor. -/
noncomputable def mapL {α β : Type} (f : α → β) (L : List α) : List β :=
  List.rec (motive := fun _ => List β) [] (fun x _ ih => f x :: ih) L

/-- Biased exponent and mantissa (with the hidden bit) of a double given by its bits, as `dexp`, `dmant`. -/
noncomputable def dexpL (u : Nat) : Nat := Nat.mod (Nat.shiftRight u 52) 2048
noncomputable def dmantL (u : Nat) : Nat := Nat.add 4503599627370496 (Nat.mod u 4503599627370496)

/-- `v` in each of `L` 64-bit lanes. -/
noncomputable def laneRepL (v L : Nat) : Nat :=
  Nat.rec (motive := fun _ => Nat) 0 (fun _ ih => Nat.lor v (Nat.shiftLeft ih 64)) L

/-- Fill each lane's highest set bit downwards (lanes of at most `64` meaningful bits, `fw` = packed lane mask). -/
noncomputable def fillDownL (fw x : Nat) : Nat :=
  let x := Nat.lor x (Nat.land (Nat.shiftRight x 1) fw)
  let x := Nat.lor x (Nat.land (Nat.shiftRight x 2) fw)
  let x := Nat.lor x (Nat.land (Nat.shiftRight x 4) fw)
  let x := Nat.lor x (Nat.land (Nat.shiftRight x 8) fw)
  let x := Nat.lor x (Nat.land (Nat.shiftRight x 16) fw)
  Nat.lor x (Nat.land (Nat.shiftRight x 32) fw)

/-- Copy bit 0 of each lane to bits `0 … 31`, then keep the low bits given by `fh` (lanes of bit 0 only). -/
noncomputable def spreadL (fh x : Nat) : Nat :=
  let x := Nat.lor x (Nat.shiftLeft x 1)
  let x := Nat.lor x (Nat.shiftLeft x 2)
  let x := Nat.lor x (Nat.shiftLeft x 4)
  let x := Nat.lor x (Nat.shiftLeft x 8)
  Nat.land (Nat.lor x (Nat.shiftLeft x 16)) fh

/-- Reverse the low `h` bits of every lane: a bit-reversal network inside the 64-bit lanes, then a shift. -/
noncomputable def revLanesL (L h x : Nat) : Nat :=
  let m1 := laneRepL 0x5555555555555555 L
  let m2 := laneRepL 0x3333333333333333 L
  let m4 := laneRepL 0x0F0F0F0F0F0F0F0F L
  let m8 := laneRepL 0x00FF00FF00FF00FF L
  let m16 := laneRepL 0x0000FFFF0000FFFF L
  let m32 := laneRepL 0x00000000FFFFFFFF L
  let x := Nat.lor (Nat.land (Nat.shiftRight x 1) m1) (Nat.shiftLeft (Nat.land x m1) 1)
  let x := Nat.lor (Nat.land (Nat.shiftRight x 2) m2) (Nat.shiftLeft (Nat.land x m2) 2)
  let x := Nat.lor (Nat.land (Nat.shiftRight x 4) m4) (Nat.shiftLeft (Nat.land x m4) 4)
  let x := Nat.lor (Nat.land (Nat.shiftRight x 8) m8) (Nat.shiftLeft (Nat.land x m8) 8)
  let x := Nat.lor (Nat.land (Nat.shiftRight x 16) m16) (Nat.shiftLeft (Nat.land x m16) 16)
  let x := Nat.lor (Nat.land (Nat.shiftRight x 32) m32) (Nat.shiftLeft (Nat.land x m32) 32)
  Nat.land (Nat.shiftRight x (Nat.sub 64 h)) (laneRepL (Nat.sub (Nat.pow 2 h) 1) L)

/-- One line update on all lanes (`full` = packed lane mask of the line length, `m` = packed match masks):
(new increments, cross increments), as `lineUpdM` in each lane. -/
noncomputable def lineUpdL (full m inc : Nat) : Nat × Nat :=
  let t := Nat.xor inc full
  let g := Nat.land t m
  let cr := Nat.land (Nat.shiftRight (Nat.xor (Nat.add t g) (Nat.xor t g)) 1) full
  let d := Nat.xor cr (Nat.land (Nat.shiftLeft cr 1) full)
  (Nat.lor (Nat.land d cr) (Nat.land inc (Nat.xor d full)), cr)

/-- Region R1 on all lanes: (V of the last column, row-`h` vertical bits, row-`h` horizontal bits; new column
`h + 1 + j` at lane bit `j`), as `region1M` in each lane. -/
noncomputable def region1L (hm1 fullh one xs : Nat) (bs : List Bool) : Nat → Nat → Nat → Nat → Nat × Nat × Nat :=
  List.rec (motive := fun _ => Nat → Nat → Nat → Nat → Nat × Nat × Nat) (fun V _ av ah => (V, av, ah))
    (fun b _ ih V j av ah =>
      let p := lineUpdL fullh (Bool.rec (motive := fun _ => Nat) (Nat.xor xs fullh) xs b) V
      ih p.1 (Nat.succ j) (Nat.lor av (Nat.shiftLeft (Nat.land (Nat.shiftRight p.1 hm1) one) j))
        (Nat.lor ah (Nat.shiftLeft (Nat.land (Nat.shiftRight p.2 hm1) one) j))) bs

/-- Region R2 on all lanes: (H of the last row, the new rows (vertical, horizontal) from the last to the first,
the vertical bits at column `β` of the new rows). -/
noncomputable def region2L (bm1 fullb one ys : Nat) (as : List Bool) :
    Nat → Nat → List (Nat × Nat) → Nat → Nat × List (Nat × Nat) × Nat :=
  List.rec (motive := fun _ => Nat → Nat → List (Nat × Nat) → Nat → Nat × List (Nat × Nat) × Nat)
    (fun H _ rows ab => (H, rows, ab))
    (fun a _ ih H j rows ab =>
      let p := lineUpdL fullb (Bool.rec (motive := fun _ => Nat) (Nat.xor ys fullb) ys a) H
      ih p.1 (Nat.succ j) ((p.2, p.1) :: rows) (Nat.lor ab (Nat.shiftLeft (Nat.land (Nat.shiftRight p.2 bm1) one) j))) as

/-- The traceback through the new rows (last row first) on all lanes: (alive lanes as bit 0, positions). -/
noncomputable def traceRowsL (fullb geh one : Nat) (rows : List (Nat × Nat)) : Nat → Nat → Nat × Nat :=
  List.rec (motive := fun _ => Nat → Nat → Nat × Nat) (fun alive pos => (alive, pos))
    (fun vh _ ih alive pos =>
      let e := Nat.lor (Nat.xor vh.1 fullb) vh.2
      let q := Nat.land (Nat.land e (fillDownL fullb pos)) geh
      let f := fillDownL fullb q
      let stop := Nat.land f (Nat.xor f (Nat.land (Nat.shiftRight f 1) fullb))
      let vs := Nat.land vh.1 stop
      ih (Nat.land (Nat.land alive f) one) (Nat.lor (Nat.xor stop vs) (Nat.land (Nat.shiftRight vs 1) fullb))) rows

/-- The transitions of all `L` lanes of a packed key literal for the input `(c, l)`: (accepted lanes as bit 0,
packed successor codes), as `kstep` in each lane. -/
noncomputable def kstepLeafL (h L keys : Nat) (c : Bool) (l : Int) : Nat × Nat :=
  let one := laneRepL 1 L
  let fullh := laneRepL (Nat.sub (Nat.pow 2 h) 1) L
  let xs := revLanesL L h (Nat.land (Nat.shiftRight keys (Nat.mul 3 h)) fullh)
  let ys := revLanesL L h (Nat.land (Nat.shiftRight keys (Nat.mul 2 h)) fullh)
  let dxs := revLanesL L h (Nat.land (Nat.shiftRight keys h) fullh)
  let dys := revLanesL L h (Nat.land keys fullh)
  let top := topStr c l
  let bot := botStr c l
  let nt := lengthF top
  let nb := lengthF bot
  let β := Nat.add h nb
  let fullb := laneRepL (Nat.sub (Nat.pow 2 β) 1) L
  let r1 := region1L (Nat.sub h 1) fullh one xs bot dxs 0 0 0
  let ysAll := Nat.lor ys (Nat.shiftLeft (laneRepL (ofLF bot) L) h)
  let r2 := region2L (Nat.sub β 1) fullb one ysAll top (Nat.lor dys (Nat.shiftLeft r1.2.2 h)) 0 [] 0
  let geh := laneRepL (Nat.sub (Nat.pow 2 β) (Nat.pow 2 (Nat.sub h 1))) L
  let t := traceRowsL fullb geh one r2.2.1 one (laneRepL (Nat.pow 2 (Nat.sub β 1)) L)
  let eh := Nat.land (Nat.lor (Nat.xor (Nat.shiftLeft r1.2.1 h) fullb) (Nat.shiftLeft r1.2.2 h))
    (laneRepL (Nat.sub (Nat.pow 2 β) (Nat.pow 2 h)) L)
  let bad := Nat.land (fillDownL fullb (Nat.land eh (fillDownL fullb t.2))) one
  let atleast := Nat.land (fillDownL fullb (Nat.land t.2 geh)) one
  let acc := Nat.land (Nat.land t.1 atleast) (Nat.xor bad one)
  let x' := Nat.land (Nat.shiftRight (Nat.lor xs (Nat.shiftLeft (laneRepL (ofLF top) L) h)) nt) fullh
  let y' := Nat.land (Nat.shiftRight ysAll nb) fullh
  let dx' := Nat.land (Nat.shiftRight (Nat.lor r1.1 (Nat.shiftLeft r2.2.2 h)) nt) fullh
  let dy' := Nat.land (Nat.shiftRight r2.1 nb) fullh
  let flm := spreadL fullh (Nat.land x' one)
  (acc, Nat.lor (Nat.lor (Nat.lor (Nat.shiftLeft (revLanesL L h (Nat.xor x' flm)) (Nat.mul 3 h))
    (Nat.shiftLeft (revLanesL L h (Nat.xor y' flm)) (Nat.mul 2 h)))
    (Nat.shiftLeft (revLanesL L h dx') h)) (revLanesL L h dy'))

/-- Bisection for the code `t` in the entries `lo … hi - 1` of a leaf (`fuel` steps). -/
noncomputable def leafFindL (t keys vals fuel : Nat) : Nat → Nat → Option Nat :=
  Nat.rec (motive := fun _ => Nat → Nat → Option Nat) (fun _ _ => none)
    (fun _ ih lo hi =>
      Bool.rec (motive := fun _ => Option Nat)
        ((fun mid => (fun km => Bool.rec (motive := fun _ => Option Nat)
            (Bool.rec (motive := fun _ => Option Nat) (ih lo mid) (ih (Nat.succ mid) hi) (Nat.ble (Nat.succ km) t))
            (some (Nat.mod (Nat.shiftRight vals (Nat.mul 64 mid)) 18446744073709551616)) (Nat.beq km t))
          (Nat.mod (Nat.shiftRight keys (Nat.mul 64 mid)) 18446744073709551616)) (Nat.shiftRight (Nat.add lo hi) 1))
        none (Nat.ble hi lo)) fuel

/-- Lookup of the value bits of a code (bisection in the leaves, at most 511 entries per leaf). -/
noncomputable def KTree.findL (T : KTree) (t : Nat) : Option Nat :=
  KTree.rec (motive := fun _ => Option Nat) (fun cnt keys vals => leafFindL t keys vals 9 0 cnt)
    (fun s _ _ fl fr => Bool.rec (motive := fun _ => Option Nat) fr fl (Nat.ble (Nat.succ t) s)) T

/-- The deepest subtree of `T` containing the key range `[lo, hi)` according to the split keys. -/
noncomputable def KTree.fingerL (T : KTree) (lo hi : Nat) : KTree :=
  KTree.rec (motive := fun _ => KTree → KTree) (fun _ _ _ self => self)
    (fun s l r fl fr self => Bool.rec (motive := fun _ => KTree)
      (Bool.rec (motive := fun _ => KTree) self (fr r) (Nat.ble s lo)) (fl l) (Nat.ble hi s)) T T

/-- Per input of a leaf: (weight, (accepted lanes, codes), (finger, top bits of lane 0's code)). -/
noncomputable def inputResL (h : Nat) (t : KTree) (wt : List Nat) (cnt keys : Nat) (p : Bool × Int) :
    Nat × (Nat × Nat) × (KTree × Nat) :=
  let r := kstepLeafL h cnt keys p.1 p.2
  let sh := Nat.mul 2 h
  let pre := Nat.shiftRight (Nat.mod r.2 18446744073709551616) sh
  let lo := Nat.shiftLeft pre sh
  (wt.getD p.2.natAbs 0, r, (t.fingerL lo (Nat.add lo (Nat.shiftLeft 1 sh)), pre))

/-- `k c`, with `c` reduced to a literal first: the kernel reduces `Nat.rec` on a literal `n + 1` by passing
`Nat.succ <lit n>` to the continuation, so equal values of different terms `c` give the same continuation term. -/
noncomputable def forceL {α : Type} (c : Nat) (k : Nat → α) : α :=
  Nat.rec (motive := fun _ => α) (k 0) (fun n _ => k (Nat.succ n)) c

/-- `Σ w · m · 2^e` over the accepted inputs of lane `j` (`m`, `e`: mantissa and exponent of the successor's value),
or `none` if a successor is missing. The successor code is forced to a literal before its lookup (the major premise of
the `Option.rec` in the continuation), so lanes of one input with equal codes give the same lookup term, which the
kernel's whnf cache evaluates once (about half of the accepted lanes; 25% faster at h = 9, 10). -/
noncomputable def laneSumL (h : Nat) (t : KTree) (j : Nat) (res : List (Nat × (Nat × Nat) × (KTree × Nat))) :
    Option Nat :=
  List.rec (motive := fun _ => Option Nat) (some 0)
    (fun x _ ih =>
      Bool.rec (motive := fun _ => Option Nat) ih
        (forceL (Nat.mod (Nat.shiftRight x.2.1.2 (Nat.mul 64 j)) 18446744073709551616) (fun c =>
          Option.rec (motive := fun _ => Option Nat) none
            (fun u => Option.rec (motive := fun _ => Option Nat) none
              (fun s => some (Nat.add s (Nat.shiftLeft (Nat.mul x.1 (dmantL u)) (dexpL u)))) ih)
            (Bool.rec (motive := fun _ => Option Nat) (t.findL c) (x.2.2.1.findL c)
              (Nat.beq (Nat.shiftRight c (Nat.mul 2 h)) x.2.2.2))))
        (Nat.beq (Nat.mod (Nat.shiftRight x.2.1.1 (Nat.mul 64 j)) 2) 1)) res

/-- `a && b` as a recursor. -/
noncomputable def andL (a b : Bool) : Bool := Bool.rec (motive := fun _ => Bool) false b a

/-- All rows of one leaf: entry `j` has `k < 2^(4h)`, `findL t k = some u`, `u` positive normal, every accepted
successor listed, and `Σ w · val(successor) ≤ lam · val(u)` (both sides scaled by `2^1075`). -/
noncomputable def leafOKL (h : Nat) (t : KTree) (wt : List Nat) (lam cnt keys vals : Nat) : Bool :=
  let res := mapL (inputResL h t wt cnt keys) (inputList h)
  let bound := Nat.pow 2 (Nat.mul 4 h)
  Nat.rec (motive := fun _ => Bool) true (fun j ih => andL ih
    ((fun k u => andL (Nat.ble (Nat.succ k) bound) (andL
      (Option.rec (motive := fun _ => Bool) false (fun v => Nat.beq v u) (t.findL k)) (andL
      (Nat.ble (Nat.succ u) 9223372036854775808) (andL (Nat.ble 1 (dexpL u)) (andL (Nat.ble (dexpL u) 2046)
      (Option.rec (motive := fun _ => Bool) false
        (fun s => Nat.ble s (Nat.shiftLeft (Nat.mul lam (dmantL u)) (dexpL u))) (laneSumL h t j res)))))))
      (Nat.mod (Nat.shiftRight keys (Nat.mul 64 j)) 18446744073709551616)
      (Nat.mod (Nat.shiftRight vals (Nat.mul 64 j)) 18446744073709551616))) cnt

/-- `p` on every leaf. -/
noncomputable def KTree.allLeavesL (p : Nat → Nat → Nat → Bool) (T : KTree) : Bool :=
  KTree.rec (motive := fun _ => Bool) (fun cnt keys vals => p cnt keys vals) (fun _ _ _ bl br => andL bl br) T

/-- The kernel check of one shard with lane-packed transitions: every entry of `sub` passes its row test, with the
lookups in the whole tree `t`. -/
noncomputable def checkKL (h : Nat) (t : KTree) (wt : List Nat) (lam : Nat) (sub : KTree) : Bool :=
  sub.allLeavesL fun cnt keys vals => leafOKL h t wt lam cnt keys vals

end CS31aCert
