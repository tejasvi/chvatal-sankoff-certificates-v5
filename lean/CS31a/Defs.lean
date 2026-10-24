import Mathlib

/-!
# The Chvátal–Sankoff constant and Lueker's automaton `M_h`: definitions

Strings over `Σ = {0,1}` are `List Bool` (`false` = 0, `true` = 1).

* `lcsLen`, `expLCS`, `gamma2`: the constant (these are the only definitions in the top theorems).
* `State`, `T`, `win`, `accepts`, `step`, `q0`, `rep`, `stepRed`, `wz`, `inputs`, `cwSum`: Lueker's automaton `M_h`
  exactly as in Section 3 of the paper (steps (1)-(5)), its complement reduction and the Collatz–Wielandt sum;
  they appear in the reduction theorem `gamma2_le_of_cw` and in the interim hypothesis `LuekerCriterion`.
-/

open Filter Topology

namespace CS31a

/-! ## The constant -/

/-- The length of a longest common subsequence of `A` and `B`: the largest length of a list that is a
subsequence (`List.Sublist`, written `<+`) of both. -/
noncomputable def lcsLen (A B : List Bool) : ℕ :=
  sSup {k : ℕ | ∃ s : List Bool, List.Sublist s A ∧ List.Sublist s B ∧ s.length = k}

/-- The expected value of `lcsLen` for two independent uniformly random binary strings of length `n`:
the average over all `4 ^ n` pairs. -/
noncomputable def expLCS (n : ℕ) : ℝ :=
  (∑ A : Fin n → Bool, ∑ B : Fin n → Bool, (lcsLen (List.ofFn A) (List.ofFn B) : ℝ)) / 4 ^ n

/-- The Chvátal–Sankoff constant `γ₂ = lim_{n → ∞} E[LCS_n] / n` (`tendsto_expLCS_div` proves that the
limit exists). -/
noncomputable def gamma2 : ℝ :=
  limUnder atTop fun n : ℕ => expLCS n / n

/-! ## Lueker's automaton `M_h` (paper, Section 3) -/

/-- A state `(x, y, d_x, d_y)` of `M_h`: the last `h` symbols of the two strings and the increments of the
dynamic-programming table down its last column and along its last row. `t : Fin h` is position `t + 1`
(oldest symbol first). -/
@[ext] structure State (h : ℕ) where
  x : Fin h → Bool
  y : Fin h → Bool
  dx : Fin h → Bool
  dy : Fin h → Bool
  deriving DecidableEq, Fintype

/-- The minimal match pair `T_{c,l}`: `(c̄^l c, c)` if `l ≥ 0` and `(c, c̄^|l| c)` if `l < 0`. -/
def T (c : Bool) (l : ℤ) : List Bool × List Bool :=
  if 0 ≤ l then (List.replicate l.toNat (!c) ++ [c], [c])
  else ([c], List.replicate l.natAbs (!c) ++ [c])

/-- Step (1): the symbols `a_1, …, a_α` of the first string after appending the first string of `T_{c,l}`
(1-indexed; values outside `1..α` are never used). -/
def symA {h : ℕ} (q : State h) (c : Bool) (l : ℤ) (r : ℕ) : Bool :=
  if hr : 1 ≤ r ∧ r ≤ h then q.x ⟨r - 1, by omega⟩ else (T c l).1.getD (r - h - 1) false

/-- Step (1): the symbols `b_1, …, b_β` of the second string after appending the second string of `T_{c,l}`. -/
def symB {h : ℕ} (q : State h) (c : Bool) (l : ℤ) (s : ℕ) : Bool :=
  if hs : 1 ≤ s ∧ s ≤ h then q.y ⟨s - 1, by omega⟩ else (T c l).2.getD (s - h - 1) false

/-- A bit as the integer `0` or `1`. -/
def bit (b : Bool) : ℤ := if b then 1 else 0

/-- Column `h` of the table of `q`: `W(r,h) = -(d_x[r+1] + … + d_x[h])`, so that `W(h,h) = 0` and
`W(r,h) - W(r-1,h) = d_x[r]`. -/
def colH {h : ℕ} (q : State h) (r : ℕ) : ℤ := -∑ t : Fin h, if r < t.val + 1 then bit (q.dx t) else 0

/-- Row `h` of the table of `q`: `W(h,s) = -(d_y[s+1] + … + d_y[h])`. -/
def rowH {h : ℕ} (q : State h) (s : ℕ) : ℤ := -∑ t : Fin h, if s < t.val + 1 then bit (q.dy t) else 0

/-- Steps (2)-(3): the window table. Row `h` and column `h` come from the state (`col`, `row`); row `0` and
column `0` are extended by constants; every cell with `max r s > h` and `r, s ≥ 1` is filled by the LCS
recurrence. Cells with `r < h` and `s < h` are never read by `win` itself, by `accepts` or by `step`;
they are set to `0`. -/
def win (h : ℕ) (a b : ℕ → Bool) (col row : ℕ → ℤ) : ℕ → ℕ → ℤ
  | r, s =>
    if r ≤ h ∧ s ≤ h then (if s = h then col r else if r = h then row s else 0)
    else if hr : r = 0 then col 0
    else if hs : s = 0 then row 0
    else if a r = b s then win h a b col row (r - 1) (s - 1) + 1
    else max (win h a b col row (r - 1) s) (win h a b col row r (s - 1))
  termination_by r s => r + s
  decreasing_by all_goals omega

/-- Step (4): the canonical traceback from `(r, s)`: up if `W(r-1,s) = W(r,s)`, else left if
`W(r,s-1) = W(r,s)`, else diagonally; it accepts when it reaches `(h,h)` and rejects when a coordinate drops
below `h`. (The guards `r = 0`, `s = 0` only matter for `h = 0`.) -/
def accepts (h : ℕ) (W : ℕ → ℕ → ℤ) : ℕ → ℕ → Bool
  | r, s =>
    if r < h ∨ s < h then false
    else if r = h ∧ s = h then true
    else if hr : r = 0 then false
    else if hs : s = 0 then false
    else if W (r - 1) s = W r s then accepts h W (r - 1) s
    else if W r (s - 1) = W r s then accepts h W r (s - 1)
    else accepts h W (r - 1) (s - 1)
  termination_by r s => r + s
  decreasing_by all_goals omega

/-- The transition `δ(q, T_{c,l})` of `M_h`, steps (1)-(5); `none` if the input is rejected. The new increments
are read off as bits (they are `0` or `1`, Lemma `step_incr`). -/
def step {h : ℕ} (q : State h) (c : Bool) (l : ℤ) : Option (State h) :=
  let α := h + (T c l).1.length
  let β := h + (T c l).2.length
  let W := win h (symA q c l) (symB q c l) (colH q) (rowH q)
  if accepts h W α β then
    some { x := fun t => symA q c l (α - h + t.val + 1)
           y := fun t => symB q c l (β - h + t.val + 1)
           dx := fun t => decide (W (α - h + t.val + 1) β - W (α - h + t.val) β = 1)
           dy := fun t => decide (W α (β - h + t.val + 1) - W α (β - h + t.val) = 1) }
  else none

/-- The start state `q₀ = (0^h, 0^h, 1^h, 1^h)`. -/
def q0 (h : ℕ) : State h := ⟨fun _ => false, fun _ => false, fun _ => true, fun _ => true⟩

/-- Complementing all symbols: `(x, y, d_x, d_y) ↦ (x̄, ȳ, d_x, d_y)`. -/
def State.compl {h : ℕ} (q : State h) : State h := ⟨fun t => !q.x t, fun t => !q.y t, q.dx, q.dy⟩

/-- The representative of `{q, q̄}` with `x[1] = 0`. -/
def rep {h : ℕ} (q : State h) : State h :=
  if h0 : 0 < h then (if q.x ⟨0, h0⟩ then q.compl else q) else q

/-- The reduced automaton: `δ_red = rep ∘ δ`. -/
def stepRed {h : ℕ} (q : State h) (c : Bool) (l : ℤ) : Option (State h) := (step q c l).map rep

/-- The inputs `T_{c,l}` of `M_h`: `c ∈ Σ`, `|l| ≤ h - 1`. -/
def inputs (h : ℕ) : Finset (Bool × ℤ) := Finset.univ ×ˢ Finset.Icc (-((h : ℤ) - 1)) ((h : ℤ) - 1)

/-- The weight `w_z(T_{c,l})` of an input with `k = |l|` (paper (3.2)): `z^(k+2)` for `k < h - 1` and
`z^(h+1)/(1-z)` (the total weight of the minimal match pairs that truncate to it) for `k = h - 1`. -/
noncomputable def wz (h : ℕ) (z : ℝ) (k : ℕ) : ℝ := if k + 1 < h then z ^ (k + 2) else z ^ (h + 1) / (1 - z)

/-- The left side of the Collatz–Wielandt inequality (paper (4.1)) for `δ_red` at `q`. -/
noncomputable def cwSum (h : ℕ) (z : ℝ) (v : State h → ℝ) (q : State h) : ℝ :=
  ∑ p ∈ inputs h, ((stepRed q p.1 p.2).map fun q' => wz h z p.2.natAbs * v q').getD 0

/-- A finite set of states containing `q₀` and closed under `δ_red`. -/
def ClosedRed {h : ℕ} (S : Finset (State h)) : Prop :=
  q0 h ∈ S ∧ ∀ q ∈ S, ∀ p ∈ inputs h, ∀ q', stepRed q p.1 p.2 = some q' → q' ∈ S

/-- Interim hypothesis (paper Theorem 4.1 + Lemma 4.2, in the log-free form): a Collatz–Wielandt vector for the
reduced automaton with parameters `z`, `λ` gives `γ₂ ≤ θ` whenever `θ > 0` and `λ^θ < (2z)^2`
(for `λ < 1` this is `θ > 2 ln(2z) / ln λ`), for `h ≥ 2`. Proved as `gamma2_le_of_cw` at milestone M-C. -/
def LuekerCriterion (h : ℕ) : Prop :=
  2 ≤ h → ∀ z lam θ : ℝ, 0 < z → z < 1 / 2 → 0 < lam → 0 < θ → lam ^ θ < (2 * z) ^ 2 →
  ∀ S : Finset (State h), ClosedRed S →
  ∀ v : State h → ℝ, (∀ q ∈ S, 0 < v q) → (∀ q ∈ S, cwSum h z v q ≤ lam * v q) → gamma2 ≤ θ

/-! ## Runs and decompositions (used by the interim hypothesis `CoverExists`) -/

/-- Truncation `μ` of a minimal match pair to an input: `T_{c,l} ↦ T_{c, sign(l) min(|l|, h-1)}`. -/
def trunc (h : ℕ) (p : Bool × ℤ) : Bool × ℤ :=
  (p.1, if 0 ≤ p.2 then min p.2 ((h : ℤ) - 1) else max p.2 (-((h : ℤ) - 1)))

/-- The run of `M_h` (not reduced) on a list of inputs; `none` if some input is rejected. -/
def runM {h : ℕ} : State h → List (Bool × ℤ) → Option (State h)
  | q, [] => some q
  | q, t :: ts => (step q t.1 t.2).bind fun q' => runM q' ts

/-- The two strings of a sequence of minimal match pairs `T_{c,l}`. -/
def strA (ps : List (Bool × ℤ)) : List Bool := (ps.map fun p => (T p.1 p.2).1).flatten
def strB (ps : List (Bool × ℤ)) : List Bool := (ps.map fun p => (T p.1 p.2).2).flatten

/-- `(A, B)` begins with `k` minimal match pairs whose truncations `M_h` accepts from `q`. -/
def HasDecomp (h : ℕ) (q : State h) (k : ℕ) (A B : List Bool) : Prop :=
  ∃ ps : List (Bool × ℤ), ps.length = k ∧ (runM q (ps.map (trunc h))).isSome = true ∧
    ∃ A' B' : List Bool, A = strA ps ++ A' ∧ B = strB ps ++ B'

/-- Interim hypothesis M-B (paper Lemma 2.3 with Lemma 3.1): every pair of strings of equal length begins, for every
`k ≤ LCS`, with `k` minimal match pairs (the first `k` pairs of its canonical decomposition) whose truncations
`M_h` accepts from `q₀`. -/
def CoverExists (h : ℕ) : Prop :=
  2 ≤ h → ∀ A B : List Bool, A.length = B.length → ∀ k ≤ lcsLen A B, HasDecomp h (q0 h) k A B

end CS31a
