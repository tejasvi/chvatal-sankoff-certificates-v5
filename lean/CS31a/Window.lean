import CS31a.Line

/-!
# The window table `win`: unfolding equations and the two regions in increment form
-/

namespace CS31a

open CS31aCert

section Win

variable (h : ℕ) (a b : ℕ → Bool) (col row : ℕ → ℤ)

theorem win_eq (r s : ℕ) : win h a b col row r s =
    if r ≤ h ∧ s ≤ h then (if s = h then col r else if r = h then row s else 0)
    else if r = 0 then col 0
    else if s = 0 then row 0
    else if a r = b s then win h a b col row (r - 1) (s - 1) + 1
    else max (win h a b col row (r - 1) s) (win h a b col row r (s - 1)) := by
  rw [win]; simp only [dite_eq_ite]

theorem win_col {r : ℕ} (hr : r ≤ h) : win h a b col row r h = col r := by
  rw [win_eq]; simp [hr]

theorem win_row {s : ℕ} (hs : s < h) : win h a b col row h s = row s := by
  rw [win_eq]; simp [hs.le, hs.ne]

theorem win_top {s : ℕ} (hs : h < s) : win h a b col row 0 s = col 0 := by
  rw [win_eq]; simp [show ¬ s ≤ h by omega]

theorem win_left {r : ℕ} (hr : h < r) : win h a b col row r 0 = row 0 := by
  rw [win_eq]; simp [show ¬ r ≤ h by omega, show r ≠ 0 by omega]

theorem win_rec {r s : ℕ} (hrs : h < r ∨ h < s) (hr : 1 ≤ r) (hs : 1 ≤ s) :
    win h a b col row r s = if a r = b s then win h a b col row (r - 1) (s - 1) + 1
      else max (win h a b col row (r - 1) s) (win h a b col row r (s - 1)) := by
  rw [win_eq]; simp [show ¬ (r ≤ h ∧ s ≤ h) by omega, show r ≠ 0 by omega, show s ≠ 0 by omega]

/-- Region R1: one new column `s > h` from column `s - 1`, rows `1..h`. -/
theorem region1_col {s : ℕ} (hs : h < s) (hcol0 : win h a b col row 0 (s - 1) = col 0) (V : List Bool)
    (hVlen : V.length = h)
    (hV : ∀ i < h, win h a b col row (1 + i) (s - 1) - win h a b col row i (s - 1) = bit (V.getD i false)) :
    let L := lineUpd (b s) ((List.range h).map fun i => a (0 + 1 + i)) V false
    L.1.length = h ∧ L.2.length = h ∧
    (∀ i < h, win h a b col row (1 + i) s - win h a b col row i s = bit (L.1.getD i false)) ∧
    (∀ i < h, win h a b col row (1 + i) s - win h a b col row (1 + i) (s - 1) = bit (L.2.getD i false)) := by
  have := lineUpd_bits (b s) a (fun p => win h a b col row p (s - 1)) (fun p => win h a b col row p s) h 0 false V
    hVlen (fun i hi => by simpa [Nat.add_comm] using hV i hi)
    (by rw [win_top h a b col row hs, hcol0]; simp [bit])
    (fun p hp1 hp2 => by rw [win_rec h a b col row (Or.inr hs) (by omega) (by omega)])
  obtain ⟨h1, h2, h3, h4⟩ := this
  refine ⟨h1, h2, fun i hi => ?_, fun i hi => ?_⟩
  · have := h3 i hi; simp only [zero_add] at this; rw [← this]
  · have := h4 i hi; simp only [zero_add] at this; rw [← this]

/-- Region R2: one new row `r > h` from row `r - 1`, columns `1..β`. -/
theorem region2_row {r : ℕ} (hr : h < r) (hrow0 : win h a b col row (r - 1) 0 = row 0) (β : ℕ) (H : List Bool)
    (hHlen : H.length = β)
    (hH : ∀ i < β, win h a b col row (r - 1) (1 + i) - win h a b col row (r - 1) i = bit (H.getD i false)) :
    let L := lineUpd (a r) ((List.range β).map fun i => b (0 + 1 + i)) H false
    L.1.length = β ∧ L.2.length = β ∧
    (∀ i < β, win h a b col row r (1 + i) - win h a b col row r i = bit (L.1.getD i false)) ∧
    (∀ i < β, win h a b col row r (1 + i) - win h a b col row (r - 1) (1 + i) = bit (L.2.getD i false)) := by
  have := lineUpd_bits (a r) b (fun p => win h a b col row (r - 1) p) (fun p => win h a b col row r p) β 0 false H
    hHlen (fun i hi => by simpa [Nat.add_comm] using hH i hi)
    (by rw [win_left h a b col row hr, hrow0]; simp [bit])
    (fun p hp1 hp2 => by
      rw [win_rec h a b col row (Or.inl hr) (by omega) (by omega)]
      by_cases hab : a r = b p
      · rw [if_pos hab, if_pos hab.symm]
      · rw [if_neg hab, if_neg (Ne.symm hab), max_comm])
  obtain ⟨h1, h2, h3, h4⟩ := this
  refine ⟨h1, h2, fun i hi => ?_, fun i hi => ?_⟩
  · have := h3 i hi; simp only [zero_add] at this; rw [← this]
  · have := h4 i hi; simp only [zero_add] at this; rw [← this]

end Win

theorem getLastD_eq_getD {α : Type*} (l : List α) (d : α) : l.getLastD d = l.getD (l.length - 1) d := by
  induction l with
  | nil => rfl
  | cons x t ih =>
    cases t with
    | nil => rfl
    | cons y u =>
      rw [List.getLastD_cons, List.getLastD_cons] at *
      simp only [List.length_cons, Nat.add_sub_cancel, List.getD_cons_succ] at ih ⊢
      rw [ih]

theorem range_succ_map {α : Type*} (m : ℕ) (f : ℕ → α) :
    (List.range (m + 1)).map f = f 0 :: (List.range m).map (fun j => f (j + 1)) := by
  rw [List.range_succ_eq_map, List.map_cons, List.map_map]; rfl

section Regions

variable (h : ℕ) (a b : ℕ → Bool) (col row : ℕ → ℤ)

/-- Region R1 over the new columns `s0+1, …, s0+m`. -/
theorem region1_spec (hh : 1 ≤ h) : ∀ (m s0 : ℕ) (V : List Bool), h ≤ s0 → V.length = h →
    (∀ i < h, win h a b col row (1 + i) s0 - win h a b col row i s0 = bit (V.getD i false)) →
    win h a b col row 0 s0 = col 0 →
    (region1 ((List.range h).map fun i => a (0 + 1 + i)) V ((List.range m).map fun j => b (s0 + 1 + j))).1.length = h ∧
    (∀ i < h, win h a b col row (1 + i) (s0 + m) - win h a b col row i (s0 + m) =
      bit ((region1 ((List.range h).map fun i => a (0 + 1 + i)) V
        ((List.range m).map fun j => b (s0 + 1 + j))).1.getD i false)) ∧
    (region1 ((List.range h).map fun i => a (0 + 1 + i)) V ((List.range m).map fun j => b (s0 + 1 + j))).2.length = m ∧
    (∀ j < m, win h a b col row h (s0 + 1 + j) - win h a b col row (h - 1) (s0 + 1 + j) =
        bit ((region1 ((List.range h).map fun i => a (0 + 1 + i)) V
          ((List.range m).map fun j => b (s0 + 1 + j))).2.getD j (false, false)).1 ∧
      win h a b col row h (s0 + 1 + j) - win h a b col row h (s0 + j) =
        bit ((region1 ((List.range h).map fun i => a (0 + 1 + i)) V
          ((List.range m).map fun j => b (s0 + 1 + j))).2.getD j (false, false)).2) := by
  intro m
  induction m with
  | zero =>
    intro s0 V _ hV hVi _
    simp only [region1, List.range_zero, List.map_nil, add_zero, List.length_nil]
    exact ⟨hV, hVi, trivial, fun j hj => absurd hj (Nat.not_lt_zero _)⟩
  | succ m ih =>
    intro s0 V hs0 hVlen hV hcol0
    rw [range_succ_map]
    simp only [region1]
    obtain ⟨l1, l2, l3, l4⟩ := region1_col h a b col row (s := s0 + 1) (by omega)
      (by rw [Nat.add_sub_cancel]; exact hcol0) V hVlen (by rw [Nat.add_sub_cancel]; exact hV)
    simp only [Nat.add_sub_cancel] at l3 l4
    have hmap : (List.range m).map (fun j => b (s0 + 1 + (j + 1))) =
        (List.range m).map (fun j => b (s0 + 1 + 1 + j)) := by
      apply List.map_congr_left; intro j _; congr 1; omega
    rw [show s0 + 1 + 0 = s0 + 1 by rfl, hmap]
    obtain ⟨i1, i2, i3, i4⟩ := ih (s0 + 1) _ (by omega) l1 l3 (win_top h a b col row (by omega))
    refine ⟨i1, fun i hi => by rw [show s0 + (m + 1) = s0 + 1 + m by ring]; exact i2 i hi, by simp [i3], ?_⟩
    intro j hj
    cases j with
    | zero =>
      simp only [List.getD_cons_zero, add_zero]
      rw [getLastD_eq_getD, getLastD_eq_getD, l1, l2]
      refine ⟨?_, ?_⟩
      · have := l3 (h - 1) (by omega); rwa [show 1 + (h - 1) = h by omega] at this
      · have := l4 (h - 1) (by omega); rwa [show 1 + (h - 1) = h by omega] at this
    | succ j =>
      simp only [List.getD_cons_succ]
      obtain ⟨j1, j2⟩ := i4 j (by omega)
      rw [show s0 + 1 + (j + 1) = s0 + 1 + 1 + j by ring, show s0 + (j + 1) = s0 + 1 + j by ring]
      exact ⟨j1, j2⟩

/-- Region R2 over the new rows `r0+1, …, r0+m`, columns `1..β`. -/
theorem region2_spec (β : ℕ) : ∀ (m r0 : ℕ) (H : List Bool), h ≤ r0 → H.length = β →
    (∀ i < β, win h a b col row r0 (1 + i) - win h a b col row r0 i = bit (H.getD i false)) →
    win h a b col row r0 0 = row 0 →
    (region2 ((List.range β).map fun i => b (0 + 1 + i)) H ((List.range m).map fun j => a (r0 + 1 + j))).1.length = β ∧
    (∀ i < β, win h a b col row (r0 + m) (1 + i) - win h a b col row (r0 + m) i =
      bit ((region2 ((List.range β).map fun i => b (0 + 1 + i)) H
        ((List.range m).map fun j => a (r0 + 1 + j))).1.getD i false)) ∧
    (region2 ((List.range β).map fun i => b (0 + 1 + i)) H ((List.range m).map fun j => a (r0 + 1 + j))).2.length = m ∧
    (∀ j < m,
      ((region2 ((List.range β).map fun i => b (0 + 1 + i)) H
          ((List.range m).map fun j => a (r0 + 1 + j))).2.getD j ([], [])).1.length = β ∧
      ((region2 ((List.range β).map fun i => b (0 + 1 + i)) H
          ((List.range m).map fun j => a (r0 + 1 + j))).2.getD j ([], [])).2.length = β ∧
      (∀ i < β, win h a b col row (r0 + 1 + j) (1 + i) - win h a b col row (r0 + j) (1 + i) =
        bit (((region2 ((List.range β).map fun i => b (0 + 1 + i)) H
          ((List.range m).map fun j => a (r0 + 1 + j))).2.getD j ([], [])).1.getD i false)) ∧
      (∀ i < β, win h a b col row (r0 + 1 + j) (1 + i) - win h a b col row (r0 + 1 + j) i =
        bit (((region2 ((List.range β).map fun i => b (0 + 1 + i)) H
          ((List.range m).map fun j => a (r0 + 1 + j))).2.getD j ([], [])).2.getD i false))) := by
  intro m
  induction m with
  | zero =>
    intro r0 H _ hH hHi _
    simp only [region2, List.range_zero, List.map_nil, add_zero, List.length_nil]
    exact ⟨hH, hHi, trivial, fun j hj => absurd hj (Nat.not_lt_zero _)⟩
  | succ m ih =>
    intro r0 H hr0 hHlen hH hrow0
    rw [range_succ_map]
    simp only [region2]
    obtain ⟨l1, l2, l3, l4⟩ := region2_row h a b col row (r := r0 + 1) (by omega)
      (by rw [Nat.add_sub_cancel]; exact hrow0) β H hHlen (by rw [Nat.add_sub_cancel]; exact hH)
    simp only [Nat.add_sub_cancel] at l3 l4
    have hmap : (List.range m).map (fun j => a (r0 + 1 + (j + 1))) =
        (List.range m).map (fun j => a (r0 + 1 + 1 + j)) := by
      apply List.map_congr_left; intro j _; congr 1; omega
    rw [show r0 + 1 + 0 = r0 + 1 by rfl, hmap]
    obtain ⟨i1, i2, i3, i4⟩ := ih (r0 + 1) _ (by omega) l1 l3 (win_left h a b col row (by omega))
    refine ⟨i1, fun i hi => by rw [show r0 + (m + 1) = r0 + 1 + m by ring]; exact i2 i hi, by simp [i3], ?_⟩
    intro j hj
    cases j with
    | zero =>
      simp only [List.getD_cons_zero, add_zero]
      exact ⟨l2, l1, l4, l3⟩
    | succ j =>
      simp only [List.getD_cons_succ]
      obtain ⟨j0, j0', j1, j2⟩ := i4 j (by omega)
      rw [show r0 + 1 + (j + 1) = r0 + 1 + 1 + j by ring, show r0 + (j + 1) = r0 + 1 + j by ring]
      exact ⟨j0, j0', j1, j2⟩

end Regions

end CS31a
