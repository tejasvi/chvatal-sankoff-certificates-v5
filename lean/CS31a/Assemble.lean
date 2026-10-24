import CS31a.CheckSound

/-!
# From a checked certificate to `γ₂ ≤ θ`

* `weightsOK`: the integer weights dominate `2^64 w_z(k)` (exact integer inequalities, `z = zn/zd`);
* `rpow_lt_of_nat`: the log-free condition `λ^θ < (2z)^2` from one integer inequality (`θ = p/q`);
* `gamma2_le_of_rows`: `rowOK` on all entries + `globalOK` + weights + the θ-inequality give `γ₂ ≤ p/q`, given the
  interim hypothesis `LuekerCriterion h` (paper Thm 4.1 + Lemma 4.2; proved at milestone M-C).
-/

namespace CS31a

open CS31aCert

/-- `wt[k] ≥ 2^64 w_z(k)` for all `k < h`, `z = zn/zd`, as integer inequalities. -/
def weightsOK (h zn zd : ℕ) (wt : List ℕ) : Bool :=
  (List.range h).all fun k =>
    if k + 1 < h then Nat.ble (2 ^ 64 * zn ^ (k + 2)) (wt.getD k 0 * zd ^ (k + 2))
    else Nat.ble (2 ^ 64 * zn ^ (h + 1)) (wt.getD k 0 * (zd ^ h * (zd - zn)))

theorem wz_le_of_weightsOK {h zn zd : ℕ} {wt : List ℕ} (hzd : 0 < zd) (hz : zn < zd)
    (hw : weightsOK h zn zd wt = true) (k : ℕ) (hk : k < h) :
    wz h ((zn : ℝ) / zd) k ≤ (wt.getD k 0 : ℝ) / 2 ^ 64 := by
  unfold weightsOK at hw
  rw [List.all_eq_true] at hw
  have hk' := hw k (List.mem_range.mpr hk)
  have hzdR : (0 : ℝ) < zd := by exact_mod_cast hzd
  unfold wz
  split_ifs at hk' ⊢ with h1
  · simp only [Nat.ble_eq] at hk'
    rw [div_pow, div_le_div_iff₀ (by positivity) (by positivity)]
    have : ((2 ^ 64 * zn ^ (k + 2) : ℕ) : ℝ) ≤ ((wt.getD k 0 * zd ^ (k + 2) : ℕ) : ℝ) := by exact_mod_cast hk'
    push_cast at this; linarith
  · simp only [Nat.ble_eq] at hk'
    have hsub : ((zd - zn : ℕ) : ℝ) = (zd : ℝ) - zn := by rw [Nat.cast_sub hz.le]
    have hpos : (0 : ℝ) < (zd : ℝ) - zn := by
      have : (zn : ℝ) < zd := by exact_mod_cast hz
      linarith
    have hne : (zd : ℝ) - zn ≠ 0 := hpos.ne'
    have hzdne : (zd : ℝ) ≠ 0 := hzdR.ne'
    have key : ((zn : ℝ) / zd) ^ (h + 1) / (1 - zn / zd) = (zn : ℝ) ^ (h + 1) / ((zd : ℝ) ^ h * ((zd : ℝ) - zn)) := by
      rw [div_pow, one_sub_div hzdne, div_div_div_eq]
      rw [div_eq_div_iff (mul_ne_zero (pow_ne_zero _ hzdne) hne) (mul_ne_zero (pow_ne_zero _ hzdne) hne)]
      ring
    have : ((2 ^ 64 * zn ^ (h + 1) : ℕ) : ℝ) ≤ ((wt.getD k 0 * (zd ^ h * (zd - zn)) : ℕ) : ℝ) := by
      exact_mod_cast hk'
    push_cast [hsub] at this
    rw [key, div_le_div_iff₀ (mul_pos (by positivity) hpos) (by positivity)]
    linarith

theorem rpow_lt_of_nat {L e zn zd p q : ℕ} (hL : 0 < L) (hzn : 0 < zn) (hzd : 0 < zd) (hq : 0 < q)
    (h : L ^ p * zd ^ (2 * q) < zn ^ (2 * q) * 2 ^ (e * p)) :
    ((L : ℝ) / 2 ^ e) ^ ((p : ℝ) / q) < ((zn : ℝ) / zd) ^ 2 := by
  have hx : (0 : ℝ) < (L : ℝ) / 2 ^ e := by positivity
  have hy : (0 : ℝ) < ((zn : ℝ) / zd) ^ 2 := by positivity
  have hxy : ((L : ℝ) / 2 ^ e) ^ p < (((zn : ℝ) / zd) ^ 2) ^ q := by
    have e1 : ((L : ℝ) / 2 ^ e) ^ p = (L : ℝ) ^ p / 2 ^ (e * p) := by rw [div_pow, ← pow_mul]
    have e2 : (((zn : ℝ) / zd) ^ 2) ^ q = (zn : ℝ) ^ (2 * q) / (zd : ℝ) ^ (2 * q) := by rw [← pow_mul, div_pow]
    rw [e1, e2, div_lt_div_iff₀ (by positivity) (by positivity)]
    exact_mod_cast h
  have hq' : (0 : ℝ) < 1 / (q : ℝ) := by positivity
  have h1 := Real.rpow_lt_rpow (by positivity) hxy hq'
  rw [← Real.rpow_natCast, ← Real.rpow_mul hx.le, ← Real.rpow_natCast (((zn : ℝ) / zd) ^ 2),
    ← Real.rpow_mul hy.le] at h1
  rw [show (q : ℝ) * (1 / q) = 1 by field_simp, Real.rpow_one, show (p : ℝ) * (1 / q) = p / q by ring] at h1
  exact h1

/-- The assembly: a passing certificate with weights and the θ-inequality gives `γ₂ ≤ p/q` (under the interim
hypothesis `LuekerCriterion h`). -/
theorem gamma2_le_of_rows {h : ℕ} (H : LuekerCriterion h) (find : ℕ → Option ℕ) (wt : List ℕ) (L : ℕ)
    (E : Finset (ℕ × ℕ)) (hfind : ∀ t u, find t = some u → (t, u) ∈ E)
    (hrows : ∀ e ∈ E, rowOK h find wt L e.1 e.2 = true) (hglob : globalOK h find wt = true)
    {zn zd : ℕ} (hzn : 0 < zn) (hz2 : 2 * zn < zd) (hw : weightsOK h zn zd wt = true)
    {p q : ℕ} (hp : 0 < p) (hq : 0 < q) (hL : 0 < L)
    (hθ : L ^ p * zd ^ (2 * q) < (2 * zn) ^ (2 * q) * 2 ^ (64 * p)) :
    gamma2 ≤ (p : ℝ) / q := by
  obtain ⟨hS, hv, hcw⟩ := sound_of_rows find wt L E hfind hrows hglob
  have hh2 : 2 ≤ h := (globalOK_spec hglob).1
  have hzd : 0 < zd := by omega
  have hzdR : (0 : ℝ) < zd := by exact_mod_cast hzd
  apply H hh2 ((zn : ℝ) / zd) ((L : ℝ) / 2 ^ 64) ((p : ℝ) / q) (by positivity)
    (by rw [div_lt_iff₀ hzdR]; have : ((2 * zn : ℕ) : ℝ) < zd := by exact_mod_cast hz2
        push_cast at this; linarith)
    (by positivity) (by positivity) ?_ _ hS (fun q => vOf find (encode q)) hv ?_
  · have := rpow_lt_of_nat (e := 64) hL (by omega : 0 < 2 * zn) hzd hq hθ
    convert this using 2; push_cast; ring
  · intro s hs
    unfold cwSum
    calc ∑ p ∈ inputs h, ((stepRed s p.1 p.2).map fun q' => wz h ((zn : ℝ) / zd) p.2.natAbs *
            vOf find (encode q')).getD 0
        ≤ ∑ p ∈ inputs h, ((stepRed s p.1 p.2).map fun q' => ((wt.getD p.2.natAbs 0 : ℝ) / 2 ^ 64) *
            vOf find (encode q')).getD 0 := by
          apply Finset.sum_le_sum
          intro p hp
          have hk : p.2.natAbs < h := by
            simp only [inputs, Finset.mem_product, Finset.mem_univ, Finset.mem_Icc, true_and] at hp
            omega
          cases stepRed s p.1 p.2 with
          | none => simp
          | some q' =>
            simp only [Option.map_some, Option.getD_some]
            exact mul_le_mul_of_nonneg_right
              (wz_le_of_weightsOK hzd (by omega) hw _ hk) (vOf_pos _ _).le
      _ = (∑ p ∈ inputs h, ((stepRed s p.1 p.2).map fun q' => (wt.getD p.2.natAbs 0 : ℝ) *
            vOf find (encode q')).getD 0) / 2 ^ 64 := by
          rw [Finset.sum_div]
          apply Finset.sum_congr rfl
          intro p _
          cases stepRed s p.1 p.2 <;> simp [div_mul_eq_mul_div]
      _ ≤ ((L : ℝ) * vOf find (encode s)) / 2 ^ 64 := by
          apply div_le_div_of_nonneg_right (hcw s hs) (by positivity)
      _ = (L : ℝ) / 2 ^ 64 * vOf find (encode s) := by ring

end CS31a
