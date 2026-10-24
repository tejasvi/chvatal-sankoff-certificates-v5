import CS31a.CheckSound
import CS31aCert.Check2

/-!
# Soundness of the native checker `checkCert2` (radix lookups, parallel decode)
-/

namespace CS31a

open CS31aCert

theorem findR_spec {keys : ByteArray} {n s : ℕ} {tab : Array ℕ} {t j : ℕ}
    (h : findR keys n s tab t = some j) : j < n ∧ getW keys j = t := by
  unfold findR at h
  simp only [Bool.and_eq_true, decide_eq_true_eq, beq_iff_eq] at h
  split_ifs at h with h1
  cases h; exact h1

theorem findValR_spec {keys vec : ByteArray} {n s : ℕ} {tab : Array ℕ} {t u : ℕ}
    (h : findValR keys vec n s tab t = some u) : ∃ j < n, getW keys j = t ∧ getW vec j = u := by
  unfold findValR at h
  cases hf : findR keys n s tab t with
  | none => rw [hf] at h; simp at h
  | some j =>
    rw [hf] at h; simp only [Option.some.injEq] at h
    obtain ⟨hj, hk⟩ := findR_spec hf
    exact ⟨j, hj, hk, h⟩

theorem rowsOK2_spec (h : ℕ) (keys vec : ByteArray) (n s : ℕ) (tab : Array ℕ) (wt : List ℕ) (lam : ℕ) :
    ∀ cnt lo, rowsOK2 h keys vec n s tab wt lam lo cnt = true → ∀ i, lo ≤ i → i < lo + cnt →
      rowOK h (findValR keys vec n s tab) wt lam (getW keys i) (getW vec i) = true := by
  intro cnt
  induction cnt with
  | zero => intro lo _ i h1 h2; omega
  | succ cnt ih =>
    intro lo hr i h1 h2
    simp only [rowsOK2, Bool.and_eq_true] at hr
    rcases Nat.eq_or_lt_of_le h1 with rfl | h1
    · exact hr.1
    · exact ih (lo + 1) hr.2 i (by omega) (by omega)

theorem checkCert2_spec {h : ℕ} {keys vec : ByteArray} {n s nb : ℕ} {wt : List ℕ} {lam chunks : ℕ}
    (hc : checkCert2 h keys vec n s nb wt lam chunks = true) :
    globalOK h (findValR keys vec n s (buildRadix keys n s nb)) wt = true ∧
      ∀ i < n, rowOK h (findValR keys vec n s (buildRadix keys n s nb)) wt lam (getW keys i) (getW vec i) = true := by
  unfold checkCert2 at hc
  simp only [Bool.and_eq_true, beq_iff_eq, Nat.ble_eq, List.all_eq_true, List.mem_map, List.mem_range] at hc
  obtain ⟨⟨⟨⟨-, -⟩, hcov⟩, hg⟩, hall⟩ := hc
  refine ⟨hg, fun i hi => ?_⟩
  set size := (n + chunks - 1) / max chunks 1 with hsize
  have hspos : 0 < size := by
    rcases Nat.eq_zero_or_pos size with h0 | h0
    · rw [h0, mul_zero] at hcov; omega
    · exact h0
  have hc : i / size < chunks := by
    rw [Nat.div_lt_iff_lt_mul hspos]; calc i < n := hi
      _ ≤ chunks * size := hcov
  have := hall _ ⟨i / size, hc, rfl⟩
  simp only [Task.spawn] at this
  apply rowsOK2_spec h keys vec n s _ wt lam _ _ this i (Nat.div_mul_le_self i size |>.trans_eq' (by ring))
  have h1 : i / size * size ≤ i := Nat.div_mul_le_self i size
  have h2 : i < i / size * size + size := by
    have := Nat.lt_div_mul_add (a := i) hspos; linarith
  rw [Nat.min_eq_right (by omega : i / size * size ≤ n)]
  omega

/-- The native check gives the hypotheses of `sound_of_rows` with `E` = the listed entries. -/
theorem checkCert2_sound {h : ℕ} {keys vec : ByteArray} {n s nb : ℕ} {wt : List ℕ} {lam chunks : ℕ}
    (hc : checkCert2 h keys vec n s nb wt lam chunks = true) :
    let E := (Finset.range n).image fun i => (getW keys i, getW vec i)
    (∀ t u, findValR keys vec n s (buildRadix keys n s nb) t = some u → (t, u) ∈ E) ∧
      (∀ e ∈ E, rowOK h (findValR keys vec n s (buildRadix keys n s nb)) wt lam e.1 e.2 = true) ∧
      globalOK h (findValR keys vec n s (buildRadix keys n s nb)) wt = true := by
  obtain ⟨hg, hrows⟩ := checkCert2_spec hc
  refine ⟨fun t u hf => ?_, fun e he => ?_, hg⟩
  · obtain ⟨j, hj, h1, h2⟩ := findValR_spec hf
    exact Finset.mem_image.mpr ⟨j, Finset.mem_range.mpr hj, by rw [h1, h2]⟩
  · obtain ⟨i, hi, rfl⟩ := Finset.mem_image.mp he
    exact hrows i (Finset.mem_range.mp hi)

theorem checkRange2_spec {h : ℕ} {keys vec : ByteArray} {n s : ℕ} {tab : Array ℕ} {wt : List ℕ} {lam lo hi chunks : ℕ}
    (hc : checkRange2 h keys vec n s tab wt lam lo hi chunks = true) :
    ∀ i, lo ≤ i → i < hi → rowOK h (findValR keys vec n s tab) wt lam (getW keys i) (getW vec i) = true := by
  intro i hlo hhi
  unfold checkRange2 at hc
  simp only [Bool.and_eq_true, Nat.ble_eq, List.all_eq_true, List.mem_map, List.mem_range] at hc
  obtain ⟨hcov, hall⟩ := hc
  set cnt := hi - lo with hcnt
  set size := (cnt + chunks - 1) / max chunks 1 with hsize
  have hspos : 0 < size := by
    rcases Nat.eq_zero_or_pos size with h0 | h0
    · rw [h0, mul_zero] at hcov; omega
    · exact h0
  set j := i - lo with hj
  have hjc : j < cnt := by omega
  have hc : j / size < chunks := by
    rw [Nat.div_lt_iff_lt_mul hspos]; calc j < cnt := hjc
      _ ≤ chunks * size := hcov
  have := hall _ ⟨j / size, hc, rfl⟩
  simp only [Task.spawn] at this
  have h1 : j / size * size ≤ j := Nat.div_mul_le_self j size
  have h2 : j < j / size * size + size := by
    have := Nat.lt_div_mul_add (a := j) hspos; linarith
  generalize j / size = q at this h1 h2
  apply rowsOK2_spec h keys vec n s _ wt lam _ _ this i (by omega)
  rw [Nat.min_eq_right (by omega : q * size ≤ cnt)]
  omega

/-- Three machine shares with ranges `[0, a)`, `[a, b)`, `[b, n)` give the hypotheses of `sound_of_rows` with
`E` = the listed entries (the decoded data, the radix table and the lookup are the same terms in all three). -/
theorem checkCertChunksR2_sound3 {h : ℕ} {keyCs vecCs : List (ℕ × ℕ)} {n s nb : ℕ} {wt : List ℕ}
    {lam a b chunks : ℕ}
    (h1 : checkCertChunksR2 h keyCs vecCs n s nb wt lam 0 a chunks = true)
    (h2 : checkCertChunksR2 h keyCs vecCs n s nb wt lam a b chunks = true)
    (h3 : checkCertChunksR2 h keyCs vecCs n s nb wt lam b n chunks = true) :
    let keys := bytesOfChunksPar keyCs
    let vec := bytesOfChunksPar vecCs
    let find := findValR keys vec n s (buildRadix keys n s nb)
    let E := (Finset.range n).image fun i => (getW keys i, getW vec i)
    (∀ t u, find t = some u → (t, u) ∈ E) ∧ (∀ e ∈ E, rowOK h find wt lam e.1 e.2 = true) ∧
      globalOK h find wt = true := by
  intro keys vec find E
  unfold checkCertChunksR2 at h1 h2 h3
  simp only [Bool.and_eq_true] at h1 h2 h3
  obtain ⟨⟨-, hg⟩, r1⟩ := h1
  obtain ⟨-, r2⟩ := h2
  obtain ⟨-, r3⟩ := h3
  refine ⟨fun t u hf => ?_, fun e he => ?_, hg⟩
  · obtain ⟨j, hj, e1, e2⟩ := findValR_spec hf
    exact Finset.mem_image.mpr ⟨j, Finset.mem_range.mpr hj, by rw [e1, e2]⟩
  · obtain ⟨i, hi, rfl⟩ := Finset.mem_image.mp he
    have hi' := Finset.mem_range.mp hi
    by_cases ha : i < a
    · exact checkRange2_spec r1 i (Nat.zero_le _) ha
    · by_cases hb : i < b
      · exact checkRange2_spec r2 i (by omega) hb
      · exact checkRange2_spec r3 i (by omega) hi'

/-- Machine shares `(lo, hi, chunks)` whose row ranges cover `[0, n)` give the hypotheses of `sound_of_rows`. -/
theorem checkCertChunksR2_soundR {h : ℕ} {keyCs vecCs : List (ℕ × ℕ)} {n s nb : ℕ} {wt : List ℕ} {lam : ℕ}
    (R : List (ℕ × ℕ × ℕ))
    (hR : ∀ r ∈ R, checkCertChunksR2 h keyCs vecCs n s nb wt lam r.1 r.2.1 r.2.2 = true)
    (r0 : ℕ × ℕ × ℕ) (hr0 : r0 ∈ R) (hcov : ∀ i < n, ∃ r ∈ R, r.1 ≤ i ∧ i < r.2.1) :
    let keys := bytesOfChunksPar keyCs
    let vec := bytesOfChunksPar vecCs
    let find := findValR keys vec n s (buildRadix keys n s nb)
    let E := (Finset.range n).image fun i => (getW keys i, getW vec i)
    (∀ t u, find t = some u → (t, u) ∈ E) ∧ (∀ e ∈ E, rowOK h find wt lam e.1 e.2 = true) ∧
      globalOK h find wt = true := by
  intro keys vec find E
  have hg := hR r0 hr0
  unfold checkCertChunksR2 at hg
  simp only [Bool.and_eq_true] at hg
  refine ⟨fun t u hf => ?_, fun e he => ?_, hg.1.2⟩
  · obtain ⟨j, hj, e1, e2⟩ := findValR_spec hf
    exact Finset.mem_image.mpr ⟨j, Finset.mem_range.mpr hj, by rw [e1, e2]⟩
  · obtain ⟨i, hi, rfl⟩ := Finset.mem_image.mp he
    obtain ⟨r, hr, h1, h2⟩ := hcov i (Finset.mem_range.mp hi)
    have hc := hR r hr
    unfold checkCertChunksR2 at hc
    simp only [Bool.and_eq_true] at hc
    exact checkRange2_spec hc.2 i h1 h2

end CS31a
