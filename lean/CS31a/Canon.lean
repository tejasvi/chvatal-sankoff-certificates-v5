import CS31a.Pad

/-!
# The canonical decomposition in the padded table (paper Lemma 2.3, in `L*`)

For `r, s ≥ h`, the traceback of `L*` from `(r, s)` takes the diagonal steps `(1,1), …, (h,h)` and then a chain
`(h,h) = c₀ < c₁ < … < c_m` of diagonal cells with `L*(c_k) = h + k`; consecutive cells satisfy `SegOK`.
-/

namespace CS31a

variable (h : ℕ) (A B : List Bool)

/-- The cells `(1,1), …, (k,k)`. -/
def diagPre (k : ℕ) : List (ℕ × ℕ) := (List.range k).map fun i => (i + 1, i + 1)

/-- Consecutive diagonal cells `(I, J) < (I', J')` of the traceback. -/
structure SegOK (p p' : ℕ × ℕ) : Prop where
  lt1 : p.1 < p'.1
  lt2 : p.2 < p'.2
  val : Lt h A B p'.1 p'.2 = Lt h A B p.1 p.2 + 1
  up : Lt h A B (p'.1 - 1) p'.2 = Lt h A B p.1 p.2
  left : Lt h A B p'.1 (p'.2 - 1) = Lt h A B p.1 p.2
  sym : symAt (padL h A) p'.1 = symAt (padL h B) p'.2
  walk : UL (Lt h A B) (p'.1 - 1, p'.2 - 1) p

/-- A chain of consecutive diagonal cells starting after `p`. -/
def ChainOK (p : ℕ × ℕ) : List (ℕ × ℕ) → Prop
  | [] => True
  | c :: cs => SegOK h A B p c ∧ ChainOK c cs

theorem chainOK_append (p : ℕ × ℕ) (cs : List (ℕ × ℕ)) (c : ℕ × ℕ) (hc : ChainOK h A B p cs)
    (hs : SegOK h A B (cs.getLastD p) c) : ChainOK h A B p (cs ++ [c]) := by
  induction cs generalizing p with
  | nil => exact ⟨hs, trivial⟩
  | cons d ds ih =>
    obtain ⟨h1, h2⟩ := hc
    rw [List.getLastD_cons] at hs
    exact ⟨h1, ih d h2 hs⟩

theorem diagPre_succ (k : ℕ) : diagPre (k + 1) = diagPre k ++ [(k + 1, k + 1)] := by
  simp [diagPre, List.range_succ]

/-- In the zero prefix the traceback is diagonal: `traceCells L* k k = (1,1), …, (k,k)` for `k ≤ h`. -/
theorem traceCells_diag (_hh : 1 ≤ h) : ∀ k, k ≤ h → traceCells (Lt h A B) k k = diagPre k := by
  intro k
  induction k with
  | zero => intro _; rw [traceCells]; simp [diagPre]
  | succ k ih =>
    intro hk
    rw [traceCells]
    have h1 : Lt h A B k (k + 1) ≠ Lt h A B (k + 1) (k + 1) := by
      rw [Lt_min h A B k (k + 1) (by omega), Lt_min h A B (k + 1) (k + 1) (by omega)]; omega
    have h2 : Lt h A B (k + 1) k ≠ Lt h A B (k + 1) (k + 1) := by
      rw [Lt_min h A B (k + 1) k (by omega), Lt_min h A B (k + 1) (k + 1) (by omega)]; omega
    simp only [Nat.add_sub_cancel, Nat.add_one_ne_zero, dite_false, h1, h2, if_false]
    rw [ih (by omega), diagPre_succ]

/-- The up/left walk from a cell with both coordinates `≥ h` stays in that region. -/
theorem UL_ge (hh : 1 ≤ h) {p q : ℕ × ℕ} (hw : UL (Lt h A B) p q) : h ≤ p.1 → h ≤ p.2 → h ≤ q.1 ∧ h ≤ q.2 := by
  induction hw with
  | refl => exact fun h1 h2 => ⟨h1, h2⟩
  | @up i j q hi hj he _ ih =>
    intro h1 h2
    apply ih _ h2
    by_contra hc
    have hi' : i = h := by simp at hc; omega
    subst hi'
    rw [Lt_min i A B (i - 1) j (by omega), Lt_min i A B i j (by omega)] at he
    omega
  | @left i j q hi hj hne he _ ih =>
    intro h1 h2
    apply ih h1
    by_contra hc
    have hj' : j = h := by simp at hc; omega
    subst hj'
    rw [Lt_min j A B i (j - 1) (by omega), Lt_min j A B i j (by omega)] at he
    omega

/-- A diagonal step of the traceback is a match with `L*` increasing by one. -/
theorem diag_step {r s : ℕ} (hr1 : 1 ≤ r) (hr2 : r ≤ (padL h A).length) (hs1 : 1 ≤ s) (hs2 : s ≤ (padL h B).length)
    (hu : Lt h A B (r - 1) s ≠ Lt h A B r s) (hl : Lt h A B r (s - 1) ≠ Lt h A B r s) :
    symAt (padL h A) r = symAt (padL h B) s ∧ Lt h A B r s = Lt h A B (r - 1) (s - 1) + 1 ∧
      Lt h A B (r - 1) s = Lt h A B (r - 1) (s - 1) ∧ Lt h A B r (s - 1) = Lt h A B (r - 1) (s - 1) := by
  have hrec := Lt_rec h A B r s hr1 hr2 hs1 hs2
  have u1 := Lt_up_le h A B (r - 1) s
  have l1 := Lt_left_le h A B r (s - 1)
  have u2 := Lt_up_le h A B (r - 1) (s - 1)
  have l2 := Lt_left_le h A B (r - 1) (s - 1)
  rw [Nat.sub_add_cancel hr1] at u1 u2
  rw [Nat.sub_add_cancel hs1] at l1 l2
  split_ifs at hrec with hab
  · refine ⟨hab, hrec, ?_, ?_⟩ <;> omega
  · exfalso
    rcases max_choice (Lt h A B (r - 1) s) (Lt h A B r (s - 1)) with hm | hm <;> rw [hm] at hrec
    · exact hu hrec.symm
    · exact hl hrec.symm

/-- The chain structure of the traceback from `(r, s)` with `r, s ≥ h`. -/
theorem trace_chain (hh : 1 ≤ h) : ∀ (n r s : ℕ), r + s ≤ n → h ≤ r → h ≤ s → r ≤ (padL h A).length →
    s ≤ (padL h B).length →
    ∃ rest, traceCells (Lt h A B) r s = diagPre h ++ rest ∧ ChainOK h A B (h, h) rest ∧
      UL (Lt h A B) (r, s) (rest.getLastD (h, h)) ∧ (∀ c ∈ rest, h < c.1 ∧ h < c.2) := by
  intro n
  induction n with
  | zero => intro r s hn hr hs _ _; omega
  | succ n ih =>
    intro r s hn hr hs hrA hsB
    rcases trace_split (Lt h A B) (r + s) r s le_rfl with ⟨i', j', hw, hb, _⟩ | ⟨i', j', hw, h1, h2, hu, hl, ht⟩
    · have := UL_ge h A B hh hw hr hs; simp at this; omega
    · have hge := UL_ge h A B hh hw hr hs
      have hle := hw.le
      simp only at hge hle
      obtain ⟨hsym, hval, hup, hlft⟩ := diag_step h A B h1 (by omega) h2 (by omega) hu hl
      by_cases hi : i' = h
      · by_cases hj : j' = h
        · refine ⟨[], ?_, trivial, by rw [List.getLastD_nil]; convert hw using 1; simp [hi, hj], by simp⟩
          rw [ht, hi, hj, traceCells_diag h A B hh (h - 1) (by omega), List.append_nil]
          obtain ⟨k, hk⟩ : ∃ k, h = k + 1 := ⟨h - 1, by omega⟩
          rw [show h - 1 = k by omega, hk, diagPre_succ]
        · exfalso
          rw [hi, Lt_min h A B h (j' - 1) (by omega), Lt_min h A B h j' (by omega)] at hl
          omega
      · by_cases hj : j' = h
        · exfalso
          rw [hj, Lt_min h A B (i' - 1) h (by omega), Lt_min h A B i' h (by omega)] at hu
          omega
        · obtain ⟨rest, hr', hc, hw', hgt⟩ := ih (i' - 1) (j' - 1) (by omega) (by omega) (by omega) (by omega)
            (by omega)
          refine ⟨rest ++ [(i', j')], by rw [ht, hr', List.append_assoc], ?_, by simpa using hw, ?_⟩
          · apply chainOK_append h A B _ _ _ hc
            have hv := hw'.val_eq
            have hwle := hw'.le
            simp only at hv hwle
            exact { lt1 := by simp only; omega
                    lt2 := by simp only; omega
                    val := by simp only; rw [hval, ← hv]
                    up := by simp only; rw [hup, ← hv]
                    left := by simp only; rw [hlft, ← hv]
                    sym := hsym
                    walk := hw' }
          · intro c hc'
            rcases List.mem_append.mp hc' with hc' | hc'
            · exact hgt c hc'
            · simp at hc'; rw [hc']; simp; omega

end CS31a
