import CS31aCert.KStep

/-!
# The kernel checker written with recursors (core Lean only, kernel use only)

The functions below compute the same values as `KTree.find`, `KTree.all`, `rowTermsK`, `rowIneq`, `kstep`, but are
defined directly by `Nat.rec`, `List.rec` and `KTree.rec` instead of structural recursion compiled to `brecOn`, which the
kernel evaluates several times more slowly. They are `noncomputable` (the code generator does not handle recursors);
they are only evaluated by the kernel (`decide +kernel`). `CS31a.checkKF_eq` proves `checkKF = checkKK`.
-/

namespace CS31aCert

noncomputable def leafFindF (t cnt : Nat) : Nat → Nat → Option Nat :=
  Nat.rec (motive := fun _ => Nat → Nat → Option Nat) (fun _ _ => none)
    (fun _ ih keys vals => cond (Nat.beq (keys % 18446744073709551616) t) (some (vals % 18446744073709551616))
      (ih (keys >>> 64) (vals >>> 64))) cnt

noncomputable def KTree.findF (T : KTree) (t : Nat) : Option Nat :=
  KTree.rec (motive := fun _ => Option Nat) (fun cnt keys vals => leafFindF t cnt keys vals)
    (fun s _ _ fl fr => cond (Nat.blt t s) fl fr) T

noncomputable def leafAllF (p : Nat → Nat → Bool) (cnt : Nat) : Nat → Nat → Bool :=
  Nat.rec (motive := fun _ => Nat → Nat → Bool) (fun _ _ => true)
    (fun _ ih keys vals => p (keys % 18446744073709551616) (vals % 18446744073709551616) && ih (keys >>> 64) (vals >>> 64))
    cnt

noncomputable def KTree.allF (p : Nat → Nat → Bool) (T : KTree) : Bool :=
  KTree.rec (motive := fun _ => Bool) (fun cnt keys vals => leafAllF p cnt keys vals) (fun _ _ _ bl br => bl && br) T

noncomputable def revBitsF (n : Nat) : Nat → Nat → Nat :=
  Nat.rec (motive := fun _ => Nat → Nat → Nat) (fun _ acc => acc) (fun _ ih x acc => ih (x >>> 1) (2 * acc + x % 2)) n

noncomputable def ofLF (L : List Bool) : Nat :=
  List.rec (motive := fun _ => Nat) 0 (fun b _ ih => cond b 1 0 + 2 * ih) L

noncomputable def lengthF {α : Type} (L : List α) : Nat :=
  List.rec (motive := fun _ => Nat) 0 (fun _ _ ih => ih + 1) L

noncomputable def region1F (hm1 full xs : Nat) (bs : List Bool) : Nat → Nat → Nat → Nat → Nat × Nat × Nat :=
  List.rec (motive := fun _ => Nat → Nat → Nat → Nat → Nat × Nat × Nat) (fun V _ av ah => (V, av, ah))
    (fun b _ ih V j av ah =>
      let p := lineUpdM full b xs V
      ih p.1 (j + 1) (av ||| (((p.1 >>> hm1) % 2) <<< j)) (ah ||| (((p.2 >>> hm1) % 2) <<< j))) bs

noncomputable def region2F (n full ys : Nat) (as : List Bool) :
    Nat → Nat → Nat → Nat → Nat → Nat → Nat × Nat × Nat × Nat :=
  List.rec (motive := fun _ => Nat → Nat → Nat → Nat → Nat → Nat → Nat × Nat × Nat × Nat)
    (fun H _ _ av ah ab => (H, av, ah, ab))
    (fun a _ ih H j sh av ah ab =>
      let p := lineUpdM full a ys H
      ih p.1 (j + 1) (sh + n) (av ||| (p.2 <<< sh)) (ah ||| (p.1 <<< sh)) (ab ||| (((p.2 >>> (n - 1)) % 2) <<< j))) as

noncomputable def traceIncF (h : Nat) (vert horiz : Nat → Nat → Bool) (fuel : Nat) : Nat → Nat → Bool :=
  Nat.rec (motive := fun _ => Nat → Nat → Bool) (fun _ _ => false)
    (fun _ ih r s =>
      cond (Nat.blt r h || Nat.blt s h) false
        (cond (Nat.beq r h && Nat.beq s h) true
          (cond (!vert r s) (ih (r - 1) s)
            (cond (!horiz r s) (ih r (s - 1)) (ih (r - 1) (s - 1)))))) fuel

/-- `kstep` with the recursor-based helpers. -/
noncomputable def kstepF (h k : Nat) (c : Bool) (l : Int) : Option Nat :=
  let full := 2 ^ h - 1
  let xs := revBitsF h (fieldX h k) 0
  let ys := revBitsF h (fieldY h k) 0
  let top := topStr c l
  let bot := botStr c l
  let nt := lengthF top
  let nb := lengthF bot
  let α := h + nt
  let β := h + nb
  let r1 := region1F (h - 1) full xs bot (revBitsF h (fieldDX h k) 0) 0 0 0
  let ysAll := ys ||| (ofLF bot <<< h)
  let r2 := region2F β (2 ^ β - 1) ysAll top (revBitsF h (fieldDY h k) 0 ||| (r1.2.2 <<< h)) 0 0 0 0 0
  let vert : Nat → Nat → Bool := fun r s =>
    cond (Nat.ble r h) (r1.2.1.testBit (s - h - 1)) (((r2.2.1 >>> (β * (r - h - 1))) % 2 ^ β).testBit (s - 1))
  let horiz : Nat → Nat → Bool := fun r s =>
    cond (Nat.ble r h) (r1.2.2.testBit (s - h - 1)) (((r2.2.2.1 >>> (β * (r - h - 1))) % 2 ^ β).testBit (s - 1))
  cond (traceIncF h vert horiz (α + β + 1) α β)
    (let x' := (xs ||| (ofLF top <<< h)) >>> nt
     let y' := ysAll >>> nb
     let dx' := (r1.1 ||| (r2.2.2.2 <<< h)) >>> nt
     let dy' := r2.1 >>> nb
     let fl := Nat.beq (x' % 2) 1
     some (packCode h (revBitsF h (cond fl (x' ^^^ full) x') 0) (revBitsF h (cond fl (y' ^^^ full) y') 0)
       (revBitsF h dx' 0) (revBitsF h dy' 0)))
    none

noncomputable def foldlF {α β : Type} (f : α → β → α) (init : α) (L : List β) : α :=
  List.rec (motive := fun _ => α → α) (fun acc => acc) (fun x _ ih acc => ih (f acc x)) L init

/-- `rowIneq` with `foldlF`. -/
noncomputable def rowIneqF (lam ui : Nat) (terms : List (Nat × Nat)) : Bool :=
  let emin := foldlF (fun m p => min m (dexp p.2)) (dexp ui) terms
  let lhs := foldlF (fun s p => s + (p.1 * dmant p.2) <<< (dexp p.2 - emin)) 0 terms
  Nat.ble lhs ((lam * dmant ui) <<< (dexp ui - emin))

noncomputable def rowTermsF (h : Nat) (find : Nat → Option Nat) (wt : List Nat) (k : Nat) (ps : List (Bool × Int)) :
    Option (List (Nat × Nat)) :=
  List.rec (motive := fun _ => Option (List (Nat × Nat))) (some [])
    (fun p _ ih =>
      Option.rec (motive := fun _ => Option (List (Nat × Nat))) ih
        (fun t => Option.rec (motive := fun _ => Option (List (Nat × Nat))) none
          (fun u => Option.rec (motive := fun _ => Option (List (Nat × Nat))) none
            (fun r => some ((wt.getD p.2.natAbs 0, u) :: r)) ih) (find t))
        (kstepF h k p.1 p.2)) ps

noncomputable def rowOKF (h : Nat) (find : Nat → Option Nat) (wt : List Nat) (lam k u : Nat) : Bool :=
  Nat.blt k (2 ^ (4 * h)) && find k == some u && posNormal u &&
    Option.rec (motive := fun _ => Bool) false (fun terms => rowIneqF lam u terms) (rowTermsF h find wt k (inputList h))

/-- The kernel check of one shard, recursor-based (equal to `checkKK` and `checkK` for `h ≥ 1`). -/
noncomputable def checkKF (h : Nat) (t : KTree) (wt : List Nat) (lam : Nat) (sub : KTree) : Bool :=
  sub.allF fun k u => rowOKF h t.findF wt lam k u

end CS31aCert
