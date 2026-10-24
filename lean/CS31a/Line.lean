import CS31a.Defs
import CS31aCert.Step

/-!
# The line update in increment form

`lineUpd sym syms inc prev` computes one new line `g` of an LCS table from the previous line `f` (positions
`k+1, …, k+n`), given the symbols `A p` of the other string, the 0/1 increments of `f` and the cross increment
`g k - f k` at the start, when `g p = if A p = sym then f (p-1) + 1 else max (g (p-1)) (f p)`.
-/

namespace CS31a

open CS31aCert

theorem bit_false : bit false = 0 := rfl
theorem bit_true : bit true = 1 := rfl

/-- One step of the line recurrence on 0/1 increments. -/
theorem line_step (u G' : ℤ) (s inc prev : Bool)
    (hG' : G' = if s then u + 1 else max (u + bit prev) (u + bit inc)) :
    G' - (u + bit inc) = bit (if s then !inc else (prev && !inc)) ∧
      G' - (u + bit prev) = bit (if (if s then !inc else (prev && !inc)) != prev
        then (if s then !inc else (prev && !inc)) else inc) := by
  subst hG'
  cases s <;> cases inc <;> cases prev <;> simp [bit]

theorem lineUpd_bits (sym : Bool) (A : ℕ → Bool) (f g : ℕ → ℤ) :
    ∀ (n k : ℕ) (prev : Bool) (incs : List Bool), incs.length = n →
      (∀ i < n, f (k + 1 + i) - f (k + i) = bit (incs.getD i false)) →
      g k - f k = bit prev →
      (∀ p, k < p → p ≤ k + n → g p = if A p = sym then f (p - 1) + 1 else max (g (p - 1)) (f p)) →
      (lineUpd sym ((List.range n).map fun i => A (k + 1 + i)) incs prev).1.length = n ∧
      (lineUpd sym ((List.range n).map fun i => A (k + 1 + i)) incs prev).2.length = n ∧
      (∀ i < n, g (k + 1 + i) - g (k + i) =
        bit ((lineUpd sym ((List.range n).map fun i => A (k + 1 + i)) incs prev).1.getD i false)) ∧
      (∀ i < n, g (k + 1 + i) - f (k + 1 + i) =
        bit ((lineUpd sym ((List.range n).map fun i => A (k + 1 + i)) incs prev).2.getD i false)) := by
  intro n
  induction n with
  | zero =>
    intro k prev incs hlen _ _ _
    rw [List.length_eq_zero_iff] at hlen; subst hlen
    simp [lineUpd]
  | succ n ih =>
    intro k prev incs hlen hf hg hrec
    obtain ⟨inc, incs', rfl⟩ : ∃ inc incs', incs = inc :: incs' := by
      cases incs with
      | nil => simp at hlen
      | cons a t => exact ⟨a, t, rfl⟩
    simp only [List.length_cons, Nat.add_right_cancel_iff] at hlen
    have hmap : (List.range (n + 1)).map (fun i => A (k + 1 + i)) =
        A (k + 1) :: (List.range n).map (fun i => A (k + 1 + 1 + i)) := by
      rw [List.range_succ_eq_map, List.map_cons, List.map_map]
      congr 1
      apply List.map_congr_left; intro i _; simp only [Function.comp]; congr 1; omega
    rw [hmap]
    -- the first position
    have hf0 : f (k + 1) = f k + bit inc := by have := hf 0 (by omega); simp at this; linarith
    have hg0 : g k = f k + bit prev := by linarith
    have hstep := line_step (f k) (g (k + 1)) (A (k + 1) == sym) inc prev (by
      rw [hrec (k + 1) (by omega) (by omega)]
      simp only [Nat.add_sub_cancel, beq_iff_eq]
      split_ifs <;> simp_all [max_comm])
    set cr := (if (A (k + 1) == sym) then !inc else (prev && !inc)) with hcr
    have hlu : lineUpd sym (A (k + 1) :: (List.range n).map (fun i => A (k + 1 + 1 + i))) (inc :: incs') prev =
        ((if cr != prev then cr else inc) ::
          (lineUpd sym ((List.range n).map (fun i => A (k + 1 + 1 + i))) incs' cr).1,
         cr :: (lineUpd sym ((List.range n).map (fun i => A (k + 1 + 1 + i))) incs' cr).2) := by
      simp only [lineUpd, hcr]
    rw [hlu]
    obtain ⟨ih1, ih2, ih3, ih4⟩ := ih (k + 1) cr incs' hlen
      (fun i hi => by have := hf (i + 1) (by omega); simp only [List.getD_cons_succ] at this
                      rw [show k + 1 + 1 + i = k + 1 + (i + 1) by omega, show k + 1 + i = k + (i + 1) by omega]
                      exact this)
      (by rw [hf0]; linarith [hstep.1])
      (fun p hp1 hp2 => hrec p (by omega) (by omega))
    refine ⟨by simp [ih1], by simp [ih2], ?_, ?_⟩
    · intro i hi
      cases i with
      | zero => simp only [List.getD_cons_zero, add_zero]; rw [hg0, ← hstep.2]
      | succ i =>
        simp only [List.getD_cons_succ]
        rw [show k + 1 + (i + 1) = k + 1 + 1 + i by omega, show k + (i + 1) = k + 1 + i by omega]
        exact ih3 i (by omega)
    · intro i hi
      cases i with
      | zero => simp only [List.getD_cons_zero, add_zero]; rw [hf0, ← hstep.1]
      | succ i =>
        simp only [List.getD_cons_succ]
        rw [show k + 1 + (i + 1) = k + 1 + 1 + i by omega]
        exact ih4 i (by omega)

end CS31a
