import CS31aCert.KTree

/-!
# A kernel-oriented transition on bit masks (core Lean only)

`kstep` computes the same function as `stepCode` (proved in `CS31a.KStepEq`), but the window table is handled as
bit masks: position `p` (1-indexed) of a line is bit `p - 1`. A line update is one carry chain, so it costs a fixed
number of `Nat` operations (which the kernel evaluates with GMP) instead of a list recursion:
with `t = ¬inc`, `g = t ∧ match`, the cross increments are the carries of `t + g`
(`cross_p = g_p ∨ (t_p ∧ cross_{p-1})`), and `newinc_p = cross_p` where `cross_p ≠ cross_{p-1}`, else `inc_p`.
-/

namespace CS31aCert

/-- The low `n` bits of `x` in reverse order, appended below `acc`. -/
def revBits : Nat → Nat → Nat → Nat
  | 0, _, acc => acc
  | n + 1, x, acc => revBits n (x >>> 1) (2 * acc + x % 2)

/-- The mask of a list of bits (head = bit 0). -/
def ofL : List Bool → Nat
  | [] => 0
  | b :: bs => (if b then 1 else 0) + 2 * ofL bs

/-- One line update on masks with `full = 2^n - 1`: (new increments, cross increments). -/
def lineUpdM (full : Nat) (sym : Bool) (syms inc : Nat) : Nat × Nat :=
  let t := inc ^^^ full
  let g := t &&& (if sym then syms else syms ^^^ full)
  let cr := ((t + g) ^^^ (t ^^^ g)) >>> 1
  let d := cr ^^^ ((cr <<< 1) &&& full)
  ((d &&& cr) ||| (inc &&& (d ^^^ full)), cr)

/-- Region R1 on masks: the new columns have symbols `bot`; rows `1..h` (`full = 2^h - 1`, row symbols `xs`).
Accumulates the row-`h` vertical / horizontal increments of new column `h+1+j` at bit `j`. -/
def region1M (hm1 full xs : Nat) : Nat → List Bool → Nat → Nat → Nat → Nat × Nat × Nat
  | V, [], _, av, ah => (V, av, ah)
  | V, b :: bs, j, av, ah =>
    let p := lineUpdM full b xs V
    region1M hm1 full xs p.1 bs (j + 1) (av ||| (((p.1 >>> hm1) % 2) <<< j)) (ah ||| (((p.2 >>> hm1) % 2) <<< j))

/-- Region R2 on masks over `n` columns (`full = 2^n - 1`, column symbols `ys`); the new rows have symbols `top`.
Row `h+1+j` has its vertical / horizontal line at bits `n j .. n j + n - 1`; `ab` collects the vertical increment at
column `n` of row `h+1+j` at bit `j`. -/
def region2M (n full ys : Nat) : Nat → List Bool → Nat → Nat → Nat → Nat → Nat → Nat × Nat × Nat × Nat
  | H, [], _, _, av, ah, ab => (H, av, ah, ab)
  | H, a :: as, j, sh, av, ah, ab =>
    let p := lineUpdM full a ys H
    region2M n full ys p.1 as (j + 1) (sh + n) (av ||| (p.2 <<< sh)) (ah ||| (p.1 <<< sh))
      (ab ||| (((p.2 >>> (n - 1)) % 2) <<< j))

/-- The transition on codes, computed on masks. -/
def kstep (h k : Nat) (c : Bool) (l : Int) : Option Nat :=
  let full := 2 ^ h - 1
  let xs := revBits h (fieldX h k) 0
  let ys := revBits h (fieldY h k) 0
  let top := topStr c l
  let bot := botStr c l
  let nt := top.length
  let nb := bot.length
  let α := h + nt
  let β := h + nb
  let r1 := region1M (h - 1) full xs (revBits h (fieldDX h k) 0) bot 0 0 0
  let ysAll := ys ||| (ofL bot <<< h)
  let r2 := region2M β (2 ^ β - 1) ysAll (revBits h (fieldDY h k) 0 ||| (r1.2.2 <<< h)) top 0 0 0 0 0
  let vert : Nat → Nat → Bool := fun r s =>
    if r ≤ h then r1.2.1.testBit (s - h - 1)
    else ((r2.2.1 >>> (β * (r - h - 1))) % 2 ^ β).testBit (s - 1)
  let horiz : Nat → Nat → Bool := fun r s =>
    if r ≤ h then r1.2.2.testBit (s - h - 1)
    else ((r2.2.2.1 >>> (β * (r - h - 1))) % 2 ^ β).testBit (s - 1)
  if traceInc h vert horiz (α + β + 1) α β then
    let x' := (xs ||| (ofL top <<< h)) >>> nt
    let y' := ysAll >>> nb
    let dx' := (r1.1 ||| (r2.2.2.2 <<< h)) >>> nt
    let dy' := r2.1 >>> nb
    let x'' := if x' % 2 = 1 then x' ^^^ full else x'
    let y'' := if x' % 2 = 1 then y' ^^^ full else y'
    some (packCode h (revBits h x'' 0) (revBits h y'' 0) (revBits h dx' 0) (revBits h dy' 0))
  else none

/-- `rowTerms` with `kstep`. -/
def rowTermsK (h : Nat) (find : Nat → Option Nat) (wt : List Nat) (k : Nat) :
    List (Bool × Int) → Option (List (Nat × Nat))
  | [] => some []
  | (c, l) :: ps =>
    match kstep h k c l with
    | none => rowTermsK h find wt k ps
    | some t =>
      match find t with
      | none => none
      | some u =>
        match rowTermsK h find wt k ps with
        | none => none
        | some r => some ((wt.getD l.natAbs 0, u) :: r)

/-- `rowOK` with `kstep`. -/
def rowOKK (h : Nat) (find : Nat → Option Nat) (wt : List Nat) (lam k u : Nat) : Bool :=
  Nat.blt k (2 ^ (4 * h)) && find k == some u && posNormal u &&
  match rowTermsK h find wt k (inputList h) with
  | none => false
  | some terms => rowIneq lam u terms

/-- The kernel check of one shard with `rowOKK` (equal to `checkK` for `h ≥ 1`, `CS31a.checkKK_eq`). -/
def checkKK (h : Nat) (t : KTree) (wt : List Nat) (lam : Nat) (sub : KTree) : Bool :=
  sub.all fun k u => rowOKK h t.find wt lam k u

end CS31aCert
