import CS31a.Decomp
import CS31a.WinMono

/-!
# Auxiliary lemmas for the covering lemma: traceback paths, telescoping, truncation
-/

namespace CS31a

theorem accepts_unfold (h : ℕ) (W : ℕ → ℕ → ℤ) (r s : ℕ) :
    accepts h W r s = if r < h ∨ s < h then false else if r = h ∧ s = h then true
      else if r = 0 then false else if s = 0 then false
      else if W (r - 1) s = W r s then accepts h W (r - 1) s
      else if W r (s - 1) = W r s then accepts h W r (s - 1)
      else accepts h W (r - 1) (s - 1) := by
  rw [accepts]; simp only [dite_eq_ite]

/-- Up moves along column `h` reach `(h, h)`. -/
theorem accepts_up_col (h : ℕ) (hh : 1 ≤ h) (W : ℕ → ℕ → ℤ) :
    ∀ R, h ≤ R → (∀ r, h < r → r ≤ R → W (r - 1) h = W r h) → accepts h W R h = true := by
  intro R
  induction R with
  | zero => intro hR; omega
  | succ R ih =>
    intro hR hW
    rw [accepts_unfold]
    by_cases hRh : R + 1 = h
    · simp [hRh]
    · have hlt : h < R + 1 := by omega
      rw [if_neg (show ¬ (R + 1 < h ∨ h < h) by omega), if_neg (show ¬ (R + 1 = h ∧ h = h) by omega),
        if_neg (show R + 1 ≠ 0 by omega), if_neg (show h ≠ 0 by omega), Nat.add_sub_cancel,
        if_pos (by have := hW (R + 1) hlt le_rfl; rwa [Nat.add_sub_cancel] at this)]
      exact ih (by omega) (fun r h1 h2 => hW r h1 (by omega))

/-- Left moves along row `h` (with "up" refused) reach `(h, h)`. -/
theorem accepts_left_row (h : ℕ) (hh : 1 ≤ h) (W : ℕ → ℕ → ℤ) :
    ∀ S, h ≤ S → (∀ s, h < s → s ≤ S → W (h - 1) s ≠ W h s ∧ W h (s - 1) = W h s) →
      accepts h W h S = true := by
  intro S
  induction S with
  | zero => intro hS; omega
  | succ S ih =>
    intro hS hW
    rw [accepts_unfold]
    by_cases hSh : S + 1 = h
    · simp [hSh]
    · have hlt : h < S + 1 := by omega
      obtain ⟨h1, h2⟩ := hW (S + 1) hlt le_rfl
      rw [Nat.add_sub_cancel] at h2
      rw [if_neg (show ¬ (h < h ∨ S + 1 < h) by omega), if_neg (show ¬ (h = h ∧ S + 1 = h) by omega),
        if_neg (show h ≠ 0 by omega), if_neg (show S + 1 ≠ 0 by omega), if_neg h1, Nat.add_sub_cancel,
        if_pos h2]
      exact ih (by omega) (fun s h1 h2 => hW s h1 (by omega))

/-- A diagonal first move. -/
theorem accepts_diag (h : ℕ) (W : ℕ → ℕ → ℤ) (r s : ℕ) (hr : h < r) (hs : h < s)
    (hu : W (r - 1) s ≠ W r s) (hl : W r (s - 1) ≠ W r s) :
    accepts h W r s = accepts h W (r - 1) (s - 1) := by
  rw [accepts_unfold]
  simp [show ¬ (r < h ∨ s < h) by omega, show ¬ (r = h ∧ s = h) by omega, show r ≠ 0 by omega,
    show s ≠ 0 by omega, hu, hl]

/-- Telescoping over `Fin h`. -/
theorem sum_fin_telescope (f : ℕ → ℤ) (r : ℕ) : ∀ h, r ≤ h →
    ∑ t : Fin h, (if r < t.val + 1 then f (t.val + 1) - f t.val else 0) = f h - f r := by
  intro h hrh
  induction h with
  | zero => rw [show r = 0 by omega]; simp
  | succ h ih =>
    rw [Fin.sum_univ_castSucc]
    simp only [Fin.coe_castSucc, Fin.val_last]
    rcases Nat.eq_or_lt_of_le hrh with heq | hlt
    · rw [heq, if_neg (by omega)]
      have : ∑ t : Fin h, (if h + 1 < t.val + 1 then f (t.val + 1) - f t.val else 0) = 0 := by
        apply Finset.sum_eq_zero; intro t _; rw [if_neg (by omega)]
      rw [this]; ring
    · rw [ih (by omega), if_pos (by omega)]; ring

theorem colH_eq_sum {h : ℕ} (q : State h) (r : ℕ) :
    colH q r = -∑ t : Fin h, if r < t.val + 1 then bit (q.dx t) else 0 := rfl

/-- The truncated pair is a suffix of the pair. -/
theorem T_trunc_suffix (h : ℕ) (hh : 2 ≤ h) (c : Bool) (lo : ℤ) :
    (T c (trunc h (c, lo)).2).1 = ((T c lo).1).drop ((T c lo).1.length - (T c (trunc h (c, lo)).2).1.length) ∧
    (T c (trunc h (c, lo)).2).2 = ((T c lo).2).drop ((T c lo).2.length - (T c (trunc h (c, lo)).2).2.length) ∧
    (T c (trunc h (c, lo)).2).1.length ≤ (T c lo).1.length ∧
    (T c (trunc h (c, lo)).2).2.length ≤ (T c lo).2.length := by
  unfold trunc
  by_cases hl : 0 ≤ lo
  · simp only [hl, if_true]
    have hm : 0 ≤ min lo ((h : ℤ) - 1) := le_min hl (by omega)
    obtain ⟨n, hn⟩ : ∃ n : ℕ, lo = n := ⟨lo.toNat, by omega⟩
    obtain ⟨n', hn'⟩ : ∃ n' : ℕ, min lo ((h : ℤ) - 1) = n' := ⟨(min lo ((h : ℤ) - 1)).toNat, by omega⟩
    have hle : n' ≤ n := by omega
    rw [hn', hn, T_nonneg, T_nonneg]
    simp only [List.length_append, List.length_replicate, List.length_singleton]
    refine ⟨?_, by simp, by omega, le_rfl⟩
    rw [show n + 1 - (n' + 1) = n - n' by omega, List.drop_append_of_le_length (by simp),
      List.drop_replicate]
    congr 2; omega
  · simp only [hl, if_false]
    have hm : max lo (-((h : ℤ) - 1)) < 0 := by omega
    obtain ⟨n, hn⟩ : ∃ n : ℕ, lo = -(n : ℤ) ∧ 1 ≤ n := ⟨(-lo).toNat, by omega, by omega⟩
    obtain ⟨n', hn'⟩ : ∃ n' : ℕ, max lo (-((h : ℤ) - 1)) = -(n' : ℤ) ∧ 1 ≤ n' :=
      ⟨(-(max lo (-((h : ℤ) - 1)))).toNat, by omega, by omega⟩
    have hle : n' ≤ n := by omega
    rw [hn'.1, hn.1, T_neg _ _ hn'.2, T_neg _ _ hn.2]
    simp only [List.length_append, List.length_replicate, List.length_singleton]
    refine ⟨by simp, ?_, le_rfl, by omega⟩
    rw [show n + 1 - (n' + 1) = n - n' by omega, List.drop_append_of_le_length (by simp),
      List.drop_replicate]
    congr 2; omega

end CS31a
