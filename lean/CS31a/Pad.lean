import CS31a.Trace

/-!
# The zero-padded table `L*` (paper Lemma 2.4)

`A* = 0^h A`, `B* = 0^h B`, `L*(r, s) = lcsLen (A*.take r) (B*.take s)`, symbols 1-indexed.
-/

namespace CS31a

/-- `0^h A`. -/
def padL (h : ℕ) (A : List Bool) : List Bool := List.replicate h false ++ A

/-- The table `L*` of the padded strings. -/
noncomputable def Lt (h : ℕ) (A B : List Bool) (r s : ℕ) : ℕ := lcsLen ((padL h A).take r) ((padL h B).take s)

/-- The `r`-th symbol (1-indexed) of a list. -/
def symAt (X : List Bool) (r : ℕ) : Bool := X.getD (r - 1) false

theorem take_succ_getD (X : List Bool) (r : ℕ) (hr : r < X.length) :
    X.take (r + 1) = X.take r ++ [X.getD r false] := by
  rw [List.take_succ, List.getD_eq_getElem _ _ hr, List.getElem?_eq_getElem hr]; rfl

theorem lcsLen_cons_left_le (c : Bool) (U V : List Bool) : lcsLen (c :: U) V ≤ lcsLen U V + 1 := by
  obtain ⟨s, h1, h2, hs⟩ := lcsLen_spec (c :: U) V
  rw [← hs]
  rcases List.sublist_cons_iff.mp h1 with h1' | ⟨r, rfl, h1'⟩
  · exact (le_lcsLen h1' h2).trans (Nat.le_succ _)
  · have : List.Sublist r V := (List.sublist_cons_self c r).trans h2
    simpa using le_lcsLen h1' this

theorem lcsLen_cons_right_le (c : Bool) (U V : List Bool) : lcsLen U (c :: V) ≤ lcsLen U V + 1 := by
  obtain ⟨s, h1, h2, hs⟩ := lcsLen_spec U (c :: V)
  rw [← hs]
  rcases List.sublist_cons_iff.mp h2 with h2' | ⟨r, rfl, h2'⟩
  · exact (le_lcsLen h1 h2').trans (Nat.le_succ _)
  · have : List.Sublist r U := (List.sublist_cons_self c r).trans h1
    simpa using le_lcsLen this h2'

/-- Paper Lemma 2.4, first part: `LCS(cU, cV) = 1 + LCS(U, V)`. -/
theorem lcsLen_cons_cons (c : Bool) (U V : List Bool) : lcsLen (c :: U) (c :: V) = lcsLen U V + 1 := by
  apply le_antisymm
  · obtain ⟨s, h1, h2, hs⟩ := lcsLen_spec (c :: U) (c :: V)
    rw [← hs]
    rcases List.sublist_cons_iff.mp h1 with h1' | ⟨r, rfl, h1'⟩
    · exact (le_lcsLen h1' h2).trans (lcsLen_cons_right_le c U V)
    · rcases List.sublist_cons_iff.mp h2 with h2' | ⟨r', hr, h2'⟩
      · exact (le_lcsLen h1 h2').trans (lcsLen_cons_left_le c U V)
      · simp only [List.cons.injEq, true_and] at hr
        subst hr
        simpa using le_lcsLen h1' h2'
  · obtain ⟨s, h1, h2, hs⟩ := lcsLen_spec U V
    have := le_lcsLen (List.cons_sublist_cons.mpr h1 : List.Sublist (c :: s) (c :: U))
      (List.cons_sublist_cons.mpr h2)
    simpa [hs] using this

theorem lcsLen_replicate_append (k : ℕ) (c : Bool) (U V : List Bool) :
    lcsLen (List.replicate k c ++ U) (List.replicate k c ++ V) = k + lcsLen U V := by
  induction k with
  | zero => simp
  | succ k ih => rw [List.replicate_succ, List.cons_append, List.cons_append, lcsLen_cons_cons, ih]; ring

/-- `L*` at the corner: `L*(h + |A|, h + |B|) = h + LCS(A, B)`. -/
theorem Lt_corner (h : ℕ) (A B : List Bool) : Lt h A B (h + A.length) (h + B.length) = h + lcsLen A B := by
  unfold Lt padL
  rw [List.take_of_length_le (by simp), List.take_of_length_le (by simp), lcsLen_replicate_append]

variable (h : ℕ) (A B : List Bool)

theorem Lt_zero_left (s : ℕ) : Lt h A B 0 s = 0 := by unfold Lt; simp [lcsLen_nil_left]
theorem Lt_zero_right (r : ℕ) : Lt h A B r 0 = 0 := by unfold Lt; simp [lcsLen_nil_right]

/-- The recurrence (2.1) for `L*`. -/
theorem Lt_rec (r s : ℕ) (hr1 : 1 ≤ r) (hr2 : r ≤ (padL h A).length) (hs1 : 1 ≤ s) (hs2 : s ≤ (padL h B).length) :
    Lt h A B r s = if symAt (padL h A) r = symAt (padL h B) s then Lt h A B (r - 1) (s - 1) + 1
      else max (Lt h A B (r - 1) s) (Lt h A B r (s - 1)) := by
  unfold Lt symAt
  obtain ⟨r', rfl⟩ : ∃ r', r = r' + 1 := ⟨r - 1, by omega⟩
  obtain ⟨s', rfl⟩ : ∃ s', s = s' + 1 := ⟨s - 1, by omega⟩
  simp only [Nat.add_sub_cancel]
  rw [take_succ_getD _ r' (by omega), take_succ_getD _ s' (by omega), lcsLen_snoc]

theorem Lt_up_le (r s : ℕ) : Lt h A B r s ≤ Lt h A B (r + 1) s ∧ Lt h A B (r + 1) s ≤ Lt h A B r s + 1 := by
  unfold Lt
  by_cases hr : r < (padL h A).length
  · rw [take_succ_getD _ r hr]
    exact ⟨lcsLen_mono (List.sublist_append_left _ _) (List.Sublist.refl _), lcsLen_snoc_left_le _ _ _⟩
  · rw [List.take_of_length_le (show (padL h A).length ≤ r + 1 by omega),
      List.take_of_length_le (show (padL h A).length ≤ r by omega)]
    exact ⟨le_rfl, Nat.le_succ _⟩

theorem Lt_left_le (r s : ℕ) : Lt h A B r s ≤ Lt h A B r (s + 1) ∧ Lt h A B r (s + 1) ≤ Lt h A B r s + 1 := by
  unfold Lt
  by_cases hs : s < (padL h B).length
  · rw [take_succ_getD _ s hs]
    exact ⟨lcsLen_mono (List.Sublist.refl _) (List.sublist_append_left _ _), lcsLen_snoc_right_le _ _ _⟩
  · rw [List.take_of_length_le (show (padL h B).length ≤ s + 1 by omega),
      List.take_of_length_le (show (padL h B).length ≤ s by omega)]
    exact ⟨le_rfl, Nat.le_succ _⟩

theorem Lt_mono {r r' s s' : ℕ} (hr : r ≤ r') (hs : s ≤ s') : Lt h A B r s ≤ Lt h A B r' s' := by
  unfold Lt
  exact lcsLen_mono ((List.take_sublist_take_left hr)) (List.take_sublist_take_left hs)

theorem take_padL_le {k : ℕ} (hk : k ≤ h) (X : List Bool) : (padL h X).take k = List.replicate k false := by
  unfold padL; rw [List.take_append_of_le_length (by simpa using hk), List.take_replicate, min_eq_left hk]

theorem replicate_sublist_take_padL {k s : ℕ} (hk : k ≤ h) (hks : k ≤ s) (X : List Bool) :
    List.Sublist (List.replicate k false) ((padL h X).take s) := by
  by_cases hs : s ≤ h
  · rw [take_padL_le h hs]; exact (List.replicate_sublist_replicate false).mpr hks
  · unfold padL
    rw [List.take_append, List.take_replicate, min_eq_right (by omega)]
    exact ((List.replicate_sublist_replicate false).mpr hk).trans (List.sublist_append_left _ _)

/-- The zero prefix: `L*(r, s) = min r s` when `min r s ≤ h`. -/
theorem Lt_min (r s : ℕ) (hrs : min r s ≤ h) : Lt h A B r s = min r s := by
  apply le_antisymm
  · unfold Lt
    rcases le_total r s with hle | hle
    · rw [min_eq_left hle]; exact (lcsLen_le_left _ _).trans (List.length_take_le _ _)
    · rw [min_eq_right hle]; exact (lcsLen_le_right _ _).trans (List.length_take_le _ _)
  · unfold Lt
    rcases le_total r s with hle | hle
    · rw [min_eq_left hle] at hrs ⊢
      have := le_lcsLen (List.Sublist.refl (List.replicate r false)) (replicate_sublist_take_padL h hrs hle B)
      rw [take_padL_le h hrs]; simpa using this
    · rw [min_eq_right hle] at hrs ⊢
      have := le_lcsLen (replicate_sublist_take_padL h hrs hle A) (List.Sublist.refl (List.replicate s false))
      rw [take_padL_le h hrs]; simpa using this

end CS31a
