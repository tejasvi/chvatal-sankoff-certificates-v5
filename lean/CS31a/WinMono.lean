import CS31a.Window

/-!
# Lemma 2.1 for the window table: all increments in the filled region are 0 or 1
-/

namespace CS31a

section

variable (h : ℕ) (a b : ℕ → Bool) (col row : ℕ → ℤ)

/-- Vertical and horizontal increments of `win` at a cell are `0` or `1`. -/
def Inc2 (r s : ℕ) : Prop :=
  (0 ≤ win h a b col row r s - win h a b col row (r - 1) s ∧ win h a b col row r s - win h a b col row (r - 1) s ≤ 1) ∧
  (0 ≤ win h a b col row r s - win h a b col row r (s - 1) ∧ win h a b col row r s - win h a b col row r (s - 1) ≤ 1)

theorem win_inc01 (hh : 1 ≤ h) (hch : col h = row h)
    (hcol : ∀ r, 1 ≤ r → r ≤ h → 0 ≤ col r - col (r - 1) ∧ col r - col (r - 1) ≤ 1)
    (hrow : ∀ s, 1 ≤ s → s ≤ h → 0 ≤ row s - row (s - 1) ∧ row s - row (s - 1) ≤ 1) :
    ∀ n r s, r + s ≤ n → 1 ≤ r → 1 ≤ s → (h < r ∨ h < s) → Inc2 h a b col row r s := by
  intro n
  induction n with
  | zero => intro r s hn _ _ _; omega
  | succ n ih =>
    intro r s hn hr hs hrs
    -- the horizontal increment at (r-1, s) and the vertical increment at (r, s-1)
    have hH : 0 ≤ win h a b col row (r - 1) s - win h a b col row (r - 1) (s - 1) ∧
        win h a b col row (r - 1) s - win h a b col row (r - 1) (s - 1) ≤ 1 := by
      by_cases h1 : r - 1 = 0
      · have hs' : h < s := by omega
        rw [h1, win_top h a b col row hs']
        by_cases h2 : s - 1 = h
        · rw [h2, win_col h a b col row (by omega)]; omega
        · rw [win_top h a b col row (by omega)]; omega
      · by_cases h2 : h < r - 1 ∨ h < s
        · exact (ih (r - 1) s (by omega) (by omega) hs h2).2
        · -- r = h + 1, s ≤ h: row h
          have hr' : r - 1 = h := by omega
          rw [hr']
          by_cases h3 : s = h
          · rw [h3, win_col h a b col row le_rfl, win_row h a b col row (by omega)]
            have := hrow h (by omega) le_rfl; rw [hch] at *; exact this
          · rw [win_row h a b col row (by omega), win_row h a b col row (by omega)]
            exact hrow s hs (by omega)
    have hV : 0 ≤ win h a b col row r (s - 1) - win h a b col row (r - 1) (s - 1) ∧
        win h a b col row r (s - 1) - win h a b col row (r - 1) (s - 1) ≤ 1 := by
      by_cases h1 : s - 1 = 0
      · have hr' : h < r := by omega
        rw [h1, win_left h a b col row hr']
        by_cases h2 : r - 1 = h
        · rw [h2, win_row h a b col row (by omega)]; omega
        · rw [win_left h a b col row (by omega)]; omega
      · by_cases h2 : h < r ∨ h < s - 1
        · exact (ih r (s - 1) (by omega) hr (by omega) h2).1
        · -- s = h + 1, r ≤ h: column h
          have hs' : s - 1 = h := by omega
          rw [hs', win_col h a b col row (by omega), win_col h a b col row (by omega)]
          exact hcol r hr (by omega)
    have hrec := win_rec h a b col row hrs hr hs
    unfold Inc2
    rw [hrec]
    split_ifs with hab
    · constructor <;> constructor <;> omega
    · rcases le_total (win h a b col row (r - 1) s) (win h a b col row r (s - 1)) with hle | hle
      · rw [max_eq_right hle]; constructor <;> constructor <;> omega
      · rw [max_eq_left hle]; constructor <;> constructor <;> omega

end

end CS31a
