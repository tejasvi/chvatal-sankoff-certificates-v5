import CS31a.Window

/-!
# Complement symmetry of `M_h` (paper (3.1)): `δ(q̄, T_{c̄,l}) = \overline{δ(q, T_{c,l})}`
-/

namespace CS31a

open CS31aCert

/-- `win` only depends on the symbols through the comparisons `a r = b s` (bounded version). -/
theorem win_congr (h : ℕ) (a b a' b' : ℕ → Bool) (col row : ℕ → ℤ) (R S : ℕ)
    (hab : ∀ r s, 1 ≤ r → r ≤ R → 1 ≤ s → s ≤ S → (a' r = b' s ↔ a r = b s)) :
    ∀ n r s, r + s ≤ n → r ≤ R → s ≤ S → win h a' b' col row r s = win h a b col row r s := by
  intro n
  induction n with
  | zero =>
    intro r s hn _ _
    obtain ⟨rfl, rfl⟩ : r = 0 ∧ s = 0 := by omega
    rw [win_eq h a' b' col row 0 0, win_eq h a b col row 0 0]
    simp only [Nat.zero_le, and_self, ↓reduceIte]
  | succ n ih =>
    intro r s hn hr hs
    rw [win_eq, win_eq h a b]
    by_cases h1 : r ≤ h ∧ s ≤ h
    · simp only [h1, and_self, if_true]
    · simp only [h1, if_false]
      by_cases hr0 : r = 0
      · simp [hr0]
      · by_cases hs0 : s = 0
        · simp [hr0, hs0]
        · simp only [hr0, hs0, if_false]
          have heq := hab r s (by omega) hr (by omega) hs
          rw [ih (r - 1) (s - 1) (by omega) (by omega) (by omega), ih (r - 1) s (by omega) (by omega) hs,
            ih r (s - 1) (by omega) hr (by omega)]
          by_cases hc : a r = b s
          · rw [if_pos (heq.mpr hc), if_pos hc]
          · rw [if_neg (fun h' => hc (heq.mp h')), if_neg hc]

/-- `accepts` only reads the table inside `[0, R] × [0, S]`. -/
theorem accepts_congr (h : ℕ) (W W' : ℕ → ℕ → ℤ) (R S : ℕ) (hW : ∀ r s, r ≤ R → s ≤ S → W' r s = W r s) :
    ∀ n r s, r + s ≤ n → r ≤ R → s ≤ S → accepts h W' r s = accepts h W r s := by
  intro n
  induction n with
  | zero =>
    intro r s hn _ _
    obtain ⟨rfl, rfl⟩ : r = 0 ∧ s = 0 := by omega
    conv_lhs => rw [accepts]
    conv_rhs => rw [accepts]
    by_cases hh : 0 < h <;> simp [hh]
  | succ n ih =>
    intro r s hn hr hs
    conv_lhs => rw [accepts]
    conv_rhs => rw [accepts]
    by_cases h1 : r < h ∨ s < h
    · simp [h1]
    · by_cases h2 : r = h ∧ s = h
      · simp [h2]
      · by_cases hr0 : r = 0
        · simp [hr0]
        · by_cases hs0 : s = 0
          · simp [hr0, hs0]
          · simp only [h1, h2, hr0, hs0, if_false, dite_false]
            rw [hW (r - 1) s (by omega) hs, hW r s hr hs, hW r (s - 1) hr (by omega),
              ih (r - 1) s (by omega) (by omega) hs, ih r (s - 1) (by omega) hr (by omega),
              ih (r - 1) (s - 1) (by omega) (by omega) (by omega)]

theorem T_not (c : Bool) (l : ℤ) : T (!c) l = ((T c l).1.map (!·), (T c l).2.map (!·)) := by
  unfold T; split_ifs <;> simp [List.map_replicate]

theorem symA_compl {h : ℕ} (q : State h) (c : Bool) (l : ℤ) (r : ℕ) (hr1 : 1 ≤ r)
    (hr2 : r ≤ h + (T c l).1.length) : symA q.compl (!c) l r = !symA q c l r := by
  unfold symA
  by_cases hrh : 1 ≤ r ∧ r ≤ h
  · rw [dif_pos hrh, dif_pos hrh]; rfl
  · rw [dif_neg hrh, dif_neg hrh, T_not]
    have hi : r - h - 1 < (T c l).1.length := by omega
    rw [List.getD_eq_getElem _ _ (by simpa using hi), List.getD_eq_getElem _ _ hi, List.getElem_map]

theorem symB_compl {h : ℕ} (q : State h) (c : Bool) (l : ℤ) (s : ℕ) (hs1 : 1 ≤ s)
    (hs2 : s ≤ h + (T c l).2.length) : symB q.compl (!c) l s = !symB q c l s := by
  unfold symB
  by_cases hsh : 1 ≤ s ∧ s ≤ h
  · rw [dif_pos hsh, dif_pos hsh]; rfl
  · rw [dif_neg hsh, dif_neg hsh, T_not]
    have hi : s - h - 1 < (T c l).2.length := by omega
    rw [List.getD_eq_getElem _ _ (by simpa using hi), List.getD_eq_getElem _ _ hi, List.getElem_map]

theorem colH_compl {h : ℕ} (q : State h) : colH q.compl = colH q := rfl
theorem rowH_compl {h : ℕ} (q : State h) : rowH q.compl = rowH q := rfl

/-- Paper (3.1). -/
theorem step_compl {h : ℕ} (q : State h) (c : Bool) (l : ℤ) :
    step q.compl (!c) l = (step q c l).map State.compl := by
  have hT1 : (T (!c) l).1.length = (T c l).1.length := by rw [T_not]; simp
  have hT2 : (T (!c) l).2.length = (T c l).2.length := by rw [T_not]; simp
  set R := h + (T c l).1.length
  set S := h + (T c l).2.length
  have hwin : ∀ r s, r ≤ R → s ≤ S →
      win h (symA q.compl (!c) l) (symB q.compl (!c) l) (colH q.compl) (rowH q.compl) r s =
        win h (symA q c l) (symB q c l) (colH q) (rowH q) r s := by
    intro r s hr hs
    rw [colH_compl, rowH_compl]
    exact win_congr h _ _ _ _ _ _ R S (fun r s hr1 hr2 hs1 hs2 => by
        rw [symA_compl q c l r hr1 hr2, symB_compl q c l s hs1 hs2]; cases symA q c l r <;> cases symB q c l s <;> simp)
      (r + s) r s le_rfl hr hs
  unfold step
  simp only [hT1, hT2]
  rw [accepts_congr h _ _ R S hwin (R + S) R S le_rfl le_rfl le_rfl]
  split_ifs with hacc
  · simp only [Option.map_some, Option.some.injEq]
    ext t
    · show symA q.compl (!c) l (R - h + t.val + 1) = !symA q c l (R - h + t.val + 1)
      exact symA_compl q c l _ (by omega) (by omega)
    · show symB q.compl (!c) l (S - h + t.val + 1) = !symB q c l (S - h + t.val + 1)
      exact symB_compl q c l _ (by omega) (by omega)
    · show decide (win h (symA q.compl (!c) l) (symB q.compl (!c) l) (colH q.compl) (rowH q.compl)
          (R - h + t.val + 1) S - win h (symA q.compl (!c) l) (symB q.compl (!c) l) (colH q.compl) (rowH q.compl)
          (R - h + t.val) S = 1) = decide (win h (symA q c l) (symB q c l) (colH q) (rowH q) (R - h + t.val + 1) S -
          win h (symA q c l) (symB q c l) (colH q) (rowH q) (R - h + t.val) S = 1)
      rw [hwin _ _ (by omega) le_rfl, hwin _ _ (by omega) le_rfl]
    · show decide (win h (symA q.compl (!c) l) (symB q.compl (!c) l) (colH q.compl) (rowH q.compl)
          R (S - h + t.val + 1) - win h (symA q.compl (!c) l) (symB q.compl (!c) l) (colH q.compl) (rowH q.compl)
          R (S - h + t.val) = 1) = decide (win h (symA q c l) (symB q c l) (colH q) (rowH q) R (S - h + t.val + 1) -
          win h (symA q c l) (symB q c l) (colH q) (rowH q) R (S - h + t.val) = 1)
      rw [hwin _ _ le_rfl (by omega), hwin _ _ le_rfl (by omega)]
  · rfl

end CS31a
