import CS31a.LCS

/-!
# The limit `γ₂ = lim E[LCS_n]/n` exists (Chvátal–Sankoff, via Fekete's lemma)
-/

open Filter Topology

namespace CS31a

/-- The sum of `lcsLen` over all pairs of strings of length `n`. -/
noncomputable def sumLCS (n : ℕ) : ℝ :=
  ∑ A : Fin n → Bool, ∑ B : Fin n → Bool, (lcsLen (List.ofFn A) (List.ofFn B) : ℝ)

theorem expLCS_eq (n : ℕ) : expLCS n = sumLCS n / 4 ^ n := rfl

theorem sumLCS_nonneg (n : ℕ) : 0 ≤ sumLCS n :=
  Finset.sum_nonneg fun _ _ => Finset.sum_nonneg fun _ _ => Nat.cast_nonneg _

theorem sumLCS_le (n : ℕ) : sumLCS n ≤ 4 ^ n * n := by
  unfold sumLCS
  calc ∑ A : Fin n → Bool, ∑ B : Fin n → Bool, (lcsLen (List.ofFn A) (List.ofFn B) : ℝ)
      ≤ ∑ A : Fin n → Bool, ∑ B : Fin n → Bool, (n : ℝ) := by
        apply Finset.sum_le_sum; intro A _; apply Finset.sum_le_sum; intro B _
        have := lcsLen_le_left (List.ofFn A) (List.ofFn B)
        rw [List.length_ofFn] at this; exact_mod_cast this
    _ = 4 ^ n * n := by
        simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fun, Fintype.card_bool, Fintype.card_fin,
          nsmul_eq_mul]
        push_cast; rw [show (4 : ℝ) = 2 * 2 by norm_num, mul_pow]; ring

theorem expLCS_le (n : ℕ) : expLCS n ≤ n := by
  rw [expLCS_eq, div_le_iff₀ (by positivity)]; linarith [sumLCS_le n]

theorem expLCS_nonneg (n : ℕ) : 0 ≤ expLCS n := div_nonneg (sumLCS_nonneg n) (by positivity)

/-- Superadditivity of the sums. -/
theorem sumLCS_add (m n : ℕ) : 4 ^ n * sumLCS m + 4 ^ m * sumLCS n ≤ sumLCS (m + n) := by
  set f : List Bool → List Bool → ℝ := fun A B => (lcsLen A B : ℝ) with hf
  have hsplit : sumLCS (m + n) = ∑ a₁ : Fin m → Bool, ∑ a₂ : Fin n → Bool, ∑ b₁ : Fin m → Bool,
      ∑ b₂ : Fin n → Bool, f (List.ofFn a₁ ++ List.ofFn a₂) (List.ofFn b₁ ++ List.ofFn b₂) := by
    unfold sumLCS
    rw [← Equiv.sum_comp (Fin.appendEquiv m n), Fintype.sum_prod_type]
    apply Finset.sum_congr rfl; intro a₁ _; apply Finset.sum_congr rfl; intro a₂ _
    rw [← Equiv.sum_comp (Fin.appendEquiv m n), Fintype.sum_prod_type]
    simp only [show ∀ p : (Fin m → Bool) × (Fin n → Bool), (Fin.appendEquiv m n) p = Fin.append p.1 p.2
      from fun _ => rfl, List.ofFn_fin_append, hf]
  have h1 : ∑ a₁ : Fin m → Bool, ∑ a₂ : Fin n → Bool, ∑ b₁ : Fin m → Bool, ∑ b₂ : Fin n → Bool,
      f (List.ofFn a₁) (List.ofFn b₁) = 4 ^ n * sumLCS m := by
    unfold sumLCS
    simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fun, Fintype.card_bool, Fintype.card_fin,
      nsmul_eq_mul, ← Finset.mul_sum, hf]
    rw [← mul_assoc]
    push_cast; rw [← mul_pow]; norm_num
  have h2 : ∑ a₁ : Fin m → Bool, ∑ a₂ : Fin n → Bool, ∑ b₁ : Fin m → Bool, ∑ b₂ : Fin n → Bool,
      f (List.ofFn a₂) (List.ofFn b₂) = 4 ^ m * sumLCS n := by
    unfold sumLCS
    simp only [Finset.sum_const, Finset.card_univ, Fintype.card_fun, Fintype.card_bool, Fintype.card_fin,
      nsmul_eq_mul, ← Finset.mul_sum, hf]
    push_cast; rw [show (4 : ℝ) = 2 * 2 by norm_num, mul_pow]; ring
  rw [hsplit, ← h1, ← h2, ← Finset.sum_add_distrib]
  apply Finset.sum_le_sum; intro a₁ _
  rw [← Finset.sum_add_distrib]; apply Finset.sum_le_sum; intro a₂ _
  rw [← Finset.sum_add_distrib]; apply Finset.sum_le_sum; intro b₁ _
  rw [← Finset.sum_add_distrib]; apply Finset.sum_le_sum; intro b₂ _
  simp only [hf]
  exact_mod_cast lcsLen_add_le _ _ _ _

theorem expLCS_add (m n : ℕ) : expLCS m + expLCS n ≤ expLCS (m + n) := by
  rw [expLCS_eq, expLCS_eq, expLCS_eq, div_add_div _ _ (by positivity) (by positivity),
    div_le_div_iff₀ (by positivity) (by positivity)]
  have := sumLCS_add m n
  have e : (4 : ℝ) ^ (m + n) = 4 ^ m * 4 ^ n := pow_add _ _ _
  rw [e]
  exact mul_le_mul_of_nonneg_right (by linarith [this]) (by positivity)

/-- `-E[LCS_n]` is subadditive. -/
theorem subadditive_negExpLCS : Subadditive (fun n => -expLCS n) := fun m n => by
  have := expLCS_add m n; simp only; linarith

/-- The Chvátal–Sankoff limit exists: `E[LCS_n]/n → γ₂`. -/
theorem tendsto_expLCS_div : Tendsto (fun n : ℕ => expLCS n / n) atTop (𝓝 gamma2) := by
  have hb : BddBelow (Set.range fun n : ℕ => -expLCS n / n) := by
    refine ⟨-1, ?_⟩
    rintro _ ⟨n, rfl⟩
    rcases Nat.eq_zero_or_pos n with rfl | hn
    · simp
    · have hn' : (0 : ℝ) < n := by exact_mod_cast hn
      rw [le_div_iff₀ hn']; linarith [expLCS_le n]
  have ht := (subadditive_negExpLCS.tendsto_lim hb).neg
  simp only [neg_div, neg_neg] at ht
  have hg : gamma2 = -subadditive_negExpLCS.lim := ht.limUnder_eq
  rw [hg]; exact ht

end CS31a
