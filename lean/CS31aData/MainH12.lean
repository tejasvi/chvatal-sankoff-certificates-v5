import CS31a.Assemble
import CS31a.CheckNative2
import CS31a.Count
import CS31a.CoverExists
import CS31aData.H12.C0
import CS31aData.H12.C1
import CS31aData.H12.C2
import CS31aData.H12.C3
import CS31aData.H12.C4
import CS31aData.H12.C5
import CS31aData.H12.C6

/-! h = 12: `γ₂ ≤ 0.822579` from the native check of the published certificate with the deterministic vector of record,
split over 7 machines (row ranges). The exact test uses `θ' = 5851/7113 ≤ 0.822579`. -/

namespace CS31aData

open CS31a CS31aCert

theorem rangesH12 : ∀ r ∈ ([(0, 3573395988, 384), (3573395988, 6756177841, 448), (6756177841, 9938959693, 448), (9938959693, 13121741545, 448), (13121741545, 16304523397, 448), (16304523397, 19487305249, 448), (19487305249, 22670087101, 448)] : List (ℕ × ℕ × ℕ)),
    checkCertChunksR2 12 keysH12 vecH12 22670087101 19 536870912 wtH12 7776813894375449830 r.1 r.2.1 r.2.2 = true := by
  intro r hr
  simp only [List.mem_cons, List.not_mem_nil, or_false] at hr
  rcases hr with rfl | rfl | rfl | rfl | rfl | rfl | rfl
  exacts [H12.cert0, H12.cert1, H12.cert2, H12.cert3, H12.cert4, H12.cert5, H12.cert6]

theorem coverH12 : ∀ i < 22670087101, ∃ r ∈ ([(0, 3573395988, 384), (3573395988, 6756177841, 448), (6756177841, 9938959693, 448), (9938959693, 13121741545, 448), (13121741545, 16304523397, 448), (16304523397, 19487305249, 448), (19487305249, 22670087101, 448)] : List (ℕ × ℕ × ℕ)), r.1 ≤ i ∧ i < r.2.1 := by
  intro i hi
  by_cases h0 : i < 3573395988
  · exact ⟨(0, 3573395988, 384), by simp, by omega, h0⟩
  by_cases h1 : i < 6756177841
  · exact ⟨(3573395988, 6756177841, 448), by simp, by omega, h1⟩
  by_cases h2 : i < 9938959693
  · exact ⟨(6756177841, 9938959693, 448), by simp, by omega, h2⟩
  by_cases h3 : i < 13121741545
  · exact ⟨(9938959693, 13121741545, 448), by simp, by omega, h3⟩
  by_cases h4 : i < 16304523397
  · exact ⟨(13121741545, 16304523397, 448), by simp, by omega, h4⟩
  by_cases h5 : i < 19487305249
  · exact ⟨(16304523397, 19487305249, 448), by simp, by omega, h5⟩
  by_cases h6 : i < 22670087101
  · exact ⟨(19487305249, 22670087101, 448), by simp, by omega, h6⟩
  omega

theorem gamma2_le_h12_of (H : LuekerCriterion 12) : gamma2 ≤ 0.822579 := by
  obtain ⟨hfind, hrows, hglob⟩ := checkCertChunksR2_soundR _ rangesH12 (0, 3573395988, 384) (by simp) coverH12
  have h1 := gamma2_le_of_rows H _ _ _ _ hfind hrows hglob (zn := 701) (zd := 2000) (by norm_num) (by norm_num)
    (by decide +kernel) (p := 5851) (q := 7113) (by norm_num) (by norm_num) (by norm_num) (by decide +kernel)
  calc gamma2 ≤ ((5851 : ℕ) : ℝ) / ((7113 : ℕ) : ℝ) := h1
    _ ≤ 0.822579 := by norm_num

/-- **No hypotheses** (native check of the published certificate, deterministic vector): `γ₂ ≤ 0.822579`. -/
theorem gamma2_le_h12 : gamma2 ≤ 0.822579 := gamma2_le_h12_of (luekerCriterion 12)

end CS31aData
