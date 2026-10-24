import CS31a.LCSRec

/-!
# The canonical traceback on a table `L : ℕ → ℕ → ℕ`

Up if `L (i-1) j = L i j`, else left if `L i (j-1) = L i j`, else diagonal; `traceCells L i j` lists the diagonal
cells (increasing). `UL L p q`: the traceback from `p` reaches `q` by up/left moves only.
-/

namespace CS31a

/-- The diagonal cells of the canonical traceback from `(i, j)`, in increasing order. -/
noncomputable def traceCells (L : ℕ → ℕ → ℕ) : ℕ → ℕ → List (ℕ × ℕ)
  | i, j =>
    if _hi : i = 0 then []
    else if _hj : j = 0 then []
    else if L (i - 1) j = L i j then traceCells L (i - 1) j
    else if L i (j - 1) = L i j then traceCells L i (j - 1)
    else traceCells L (i - 1) (j - 1) ++ [(i, j)]
  termination_by i j => i + j
  decreasing_by all_goals omega

/-- The traceback moves from `p` to `q` by up/left moves only (following the canonical choice). -/
inductive UL (L : ℕ → ℕ → ℕ) : ℕ × ℕ → ℕ × ℕ → Prop
  | refl (p : ℕ × ℕ) : UL L p p
  | up {i j : ℕ} {q : ℕ × ℕ} : 1 ≤ i → 1 ≤ j → L (i - 1) j = L i j → UL L (i - 1, j) q → UL L (i, j) q
  | left {i j : ℕ} {q : ℕ × ℕ} : 1 ≤ i → 1 ≤ j → L (i - 1) j ≠ L i j → L i (j - 1) = L i j →
      UL L (i, j - 1) q → UL L (i, j) q

variable {L : ℕ → ℕ → ℕ}

theorem UL.val_eq {p q : ℕ × ℕ} (h : UL L p q) : L q.1 q.2 = L p.1 p.2 := by
  induction h with
  | refl => rfl
  | up _ _ he _ ih => rw [ih]; exact he
  | left _ _ _ he _ ih => rw [ih]; exact he

theorem UL.le {p q : ℕ × ℕ} (h : UL L p q) : q.1 ≤ p.1 ∧ q.2 ≤ p.2 := by
  induction h with
  | refl => exact ⟨le_rfl, le_rfl⟩
  | up _ _ _ _ ih => exact ⟨by simp at ih; omega, by simpa using ih.2⟩
  | left _ _ _ _ _ ih => exact ⟨by simpa using ih.1, by simp at ih; omega⟩

/-- A walk that stays in its row refuses "up" at every visited cell after the endpoint. -/
theorem UL.row' {p q : ℕ × ℕ} (h : UL L p q) :
    p.1 = q.1 → ∀ t, q.2 < t → t ≤ p.2 → 1 ≤ p.1 ∧ L (p.1 - 1) t ≠ L p.1 t := by
  induction h with
  | refl => intro _ t h1 h2; omega
  | @up i j q' hi hj he hw ih =>
    intro hrow
    have := hw.le
    simp at this hrow; omega
  | @left i j q' hi hj hne he hw ih =>
    intro hrow t h1 h2
    simp only at hrow ih ⊢
    rcases Nat.eq_or_lt_of_le h2 with rfl | h2
    · exact ⟨hi, hne⟩
    · exact ih hrow t h1 (by omega)

theorem UL.row {r s s' : ℕ} (h : UL L (r, s) (r, s')) :
    ∀ t, s' < t → t ≤ s → 1 ≤ r ∧ L (r - 1) t ≠ L r t :=
  h.row' rfl

/-- The traceback from `(i, j)` either reaches the boundary by up/left moves (no diagonal cell), or reaches by
up/left moves a cell `(i', j')` where it moves diagonally. -/
theorem trace_split (L : ℕ → ℕ → ℕ) : ∀ (n i j : ℕ), i + j ≤ n →
    (∃ i' j', UL L (i, j) (i', j') ∧ (i' = 0 ∨ j' = 0) ∧ traceCells L i j = []) ∨
    (∃ i' j', UL L (i, j) (i', j') ∧ 1 ≤ i' ∧ 1 ≤ j' ∧ L (i' - 1) j' ≠ L i' j' ∧ L i' (j' - 1) ≠ L i' j' ∧
      traceCells L i j = traceCells L (i' - 1) (j' - 1) ++ [(i', j')]) := by
  intro n
  induction n with
  | zero =>
    intro i j h
    left; refine ⟨i, j, UL.refl _, by omega, ?_⟩
    rw [traceCells]; simp [show i = 0 by omega]
  | succ n ih =>
    intro i j h
    by_cases hi : i = 0
    · left; exact ⟨i, j, UL.refl _, Or.inl hi, by rw [traceCells]; simp [hi]⟩
    by_cases hj : j = 0
    · left; exact ⟨i, j, UL.refl _, Or.inr hj, by rw [traceCells]; simp [hi, hj]⟩
    by_cases hu : L (i - 1) j = L i j
    · have ht : traceCells L i j = traceCells L (i - 1) j := by rw [traceCells]; simp [hi, hj, hu]
      rcases ih (i - 1) j (by omega) with ⟨i', j', hw, hb, he⟩ | ⟨i', j', hw, h1, h2, h3, h4, he⟩
      · left; exact ⟨i', j', UL.up (by omega) (by omega) hu hw, hb, ht.trans he⟩
      · right; exact ⟨i', j', UL.up (by omega) (by omega) hu hw, h1, h2, h3, h4, ht.trans he⟩
    by_cases hl : L i (j - 1) = L i j
    · have ht : traceCells L i j = traceCells L i (j - 1) := by rw [traceCells]; simp [hi, hj, hu, hl]
      rcases ih i (j - 1) (by omega) with ⟨i', j', hw, hb, he⟩ | ⟨i', j', hw, h1, h2, h3, h4, he⟩
      · left; exact ⟨i', j', UL.left (by omega) (by omega) hu hl hw, hb, ht.trans he⟩
      · right; exact ⟨i', j', UL.left (by omega) (by omega) hu hl hw, h1, h2, h3, h4, ht.trans he⟩
    · right
      refine ⟨i, j, UL.refl _, by omega, by omega, hu, hl, ?_⟩
      rw [traceCells]; simp [hi, hj, hu, hl]

end CS31a
