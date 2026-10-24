import CS31aCert.Step

/-!
# The row test of the Collatz–Wielandt certificate, generic in the lookup (core Lean only)

A certificate is a finite set of entries `(k, u)`: a state code `k` and the bits `u` of an IEEE double `v(k)`.
`find : ℕ → Option ℕ` returns the value bits of a listed code. The real value of positive normal bits `u` is
`val u = dmant u · 2^(dexp u - 1075)`. Row `(k, u)` passes if `k < 2^(4h)`, `find k = some u`, `u` is positive
normal, every accepted reduced successor `t` of `k` is listed, and
`Σ_{accepted (c,l)} wt[|l|] · val(find t) ≤ lam · val u` exactly (both sides scaled by `2^(1075 - e_min)`).
Both the native checker (lookup in byte arrays) and the kernel checker (lookup in a tree of literals) use `rowOK`.
-/

namespace CS31aCert

/-- Biased exponent and mantissa (with the hidden bit) of a double given by its bits. -/
@[inline] def dexp (u : Nat) : Nat := (u >>> 52) % 2048
@[inline] def dmant (u : Nat) : Nat := 2 ^ 52 + u % 2 ^ 52

/-- A positive normal double: sign 0, biased exponent in `1..2046`. -/
@[inline] def posNormal (u : Nat) : Bool := u < 2 ^ 63 && 1 ≤ dexp u && dexp u ≤ 2046

/-- The terms `(wt[|l|], bits of v(successor))` of row `k`, or `none` if an accepted successor is not listed. -/
@[specialize] def rowTerms (h : Nat) (find : Nat → Option Nat) (wt : List Nat) (k : Nat) :
    List (Bool × Int) → Option (List (Nat × Nat))
  | [] => some []
  | (c, l) :: ps =>
    match stepCode h k c l with
    | none => rowTerms h find wt k ps
    | some t =>
      match find t with
      | none => none
      | some u =>
        match rowTerms h find wt k ps with
        | none => none
        | some r => some ((wt.getD l.natAbs 0, u) :: r)

/-- The exact row inequality `Σ w · val(u_t) ≤ lam · val(ui)` after scaling by `2^(1075 - e_min)`. -/
def rowIneq (lam ui : Nat) (terms : List (Nat × Nat)) : Bool :=
  let emin := terms.foldl (fun m p => min m (dexp p.2)) (dexp ui)
  let lhs := terms.foldl (fun s p => s + (p.1 * dmant p.2) <<< (dexp p.2 - emin)) 0
  Nat.ble lhs ((lam * dmant ui) <<< (dexp ui - emin))

/-- All conditions for the entry `(k, u)`. -/
@[specialize] def rowOK (h : Nat) (find : Nat → Option Nat) (wt : List Nat) (lam k u : Nat) : Bool :=
  Nat.blt k (2 ^ (4 * h)) && find k == some u && posNormal u &&
  match rowTerms h find wt k (inputList h) with
  | none => false
  | some terms => rowIneq lam u terms

/-- The global conditions: `2 ≤ h`, one weight per `|l| < h`, and the start state is listed. -/
@[specialize] def globalOK (h : Nat) (find : Nat → Option Nat) (wt : List Nat) : Bool :=
  Nat.ble 2 h && wt.length == h && (find (startCode h)).isSome

end CS31aCert
