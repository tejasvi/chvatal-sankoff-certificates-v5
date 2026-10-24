import CS31a.CheckNative2
import CS31aCert.Check13

/-!
# Soundness of the compact native checker `checkCert13R` (h = 13)

Machine shares `(lo, hi, chunks)` of `checkCert13R` whose row ranges cover `[0, n)` give the hypotheses of
`sound_of_rows` with `find := C.findVal` and `E` = the listed entries `(C.keyOf i, C.valAt i)`, `i < n`.

* the table check `tabMono` gives `tab b ≤ tab (b + 1)` for `b < nb`, so the bucket intervals `[tab b, tab (b + 1))`,
  `b < nb`, are disjoint;
* the row test of `i` re-checks its bucket `bucketOf i` (`< nb`, contains `i`) and gives `rowOK` for its key;
* a lookup `C.find t = some j` re-checks `j < n`, `j` in the bucket `t >>> sb`, `low j = t % 2^sb`; the row test of `j`
  and disjointness give `bucketOf j = t >>> sb`, hence `keyOf j = t`.

No property of the bisections (`bucketSearch`, `lowSearch`), of the decoding or of `f32to64` is used.
-/

namespace CS31a

open CS31aCert

/-! ### The table is monotone -/

theorem monoOK13_spec (C : Cert13) : ∀ cnt lo, C.monoOK lo cnt = true → ∀ b, lo ≤ b → b < lo + cnt →
    C.tabAt b ≤ C.tabAt (b + 1) := by
  intro cnt
  induction cnt with
  | zero => intro lo _ b h1 h2; omega
  | succ cnt ih =>
    intro lo hr b h1 h2
    simp only [Cert13.monoOK, Bool.and_eq_true, decide_eq_true_eq] at hr
    rcases Nat.eq_or_lt_of_le h1 with rfl | h1
    · exact hr.1
    · exact ih (lo + 1) hr.2 b (by omega) (by omega)

theorem tabMono13_spec {C : Cert13} {parts : ℕ} (hm : C.tabMono parts = true) :
    ∀ b < C.nb, C.tabAt b ≤ C.tabAt (b + 1) := by
  intro b hb
  unfold Cert13.tabMono at hm
  simp only [Bool.and_eq_true, Nat.ble_eq, List.all_eq_true, List.mem_map, List.mem_range] at hm
  obtain ⟨hcov, hall⟩ := hm
  set size := (C.nb + parts - 1) / max parts 1 with hsize
  have hspos : 0 < size := by
    rcases Nat.eq_zero_or_pos size with h0 | h0
    · rw [h0, mul_zero] at hcov; omega
    · exact h0
  have hc : b / size < parts := by
    rw [Nat.div_lt_iff_lt_mul hspos]; calc b < C.nb := hb
      _ ≤ parts * size := hcov
  have := hall _ ⟨b / size, hc, rfl⟩
  simp only [Task.spawn] at this
  have h1 : b / size * size ≤ b := Nat.div_mul_le_self b size
  have h2 : b < b / size * size + size := by
    have := Nat.lt_div_mul_add (a := b) hspos; linarith
  generalize b / size = q at this h1 h2
  apply monoOK13_spec C _ _ this b h1
  rw [Nat.min_eq_right (by omega : q * size ≤ C.nb)]
  omega

theorem tabAt_mono13 {C : Cert13} (hmono : ∀ b < C.nb, C.tabAt b ≤ C.tabAt (b + 1)) :
    ∀ d x, x + d ≤ C.nb → C.tabAt x ≤ C.tabAt (x + d) := by
  intro d
  induction d with
  | zero => intro x _; exact le_rfl
  | succ d ih =>
    intro x hx
    rw [← Nat.add_assoc]
    exact (ih x (by omega)).trans (hmono (x + d) (by omega))

/-- The buckets `[tab b, tab (b + 1))`, `b < nb`, of a monotone table are disjoint. -/
theorem bucket_unique13 {C : Cert13} (hmono : ∀ b < C.nb, C.tabAt b ≤ C.tabAt (b + 1)) {b b' j : ℕ}
    (hb : b < C.nb) (hb' : b' < C.nb) (h1 : C.tabAt b ≤ j) (h2 : j < C.tabAt (b + 1))
    (h1' : C.tabAt b' ≤ j) (h2' : j < C.tabAt (b' + 1)) : b = b' := by
  by_contra hne
  rcases Nat.lt_or_gt_of_ne hne with hlt | hlt
  · have := tabAt_mono13 hmono (b' - (b + 1)) (b + 1) (by omega)
    rw [show b + 1 + (b' - (b + 1)) = b' by omega] at this
    omega
  · have := tabAt_mono13 hmono (b - (b' + 1)) (b' + 1) (by omega)
    rw [show b' + 1 + (b - (b' + 1)) = b by omega] at this
    omega

/-! ### Rows -/

theorem rowsOK13_spec (h : ℕ) (C : Cert13) (wt : List ℕ) (lam : ℕ) :
    ∀ cnt lo, C.rowsOK13 h wt lam lo cnt = true → ∀ i, lo ≤ i → i < lo + cnt → C.rowOK13 h wt lam i = true := by
  intro cnt
  induction cnt with
  | zero => intro lo _ i h1 h2; omega
  | succ cnt ih =>
    intro lo hr i h1 h2
    simp only [Cert13.rowsOK13, Bool.and_eq_true] at hr
    rcases Nat.eq_or_lt_of_le h1 with rfl | h1
    · exact hr.1
    · exact ih (lo + 1) hr.2 i (by omega) (by omega)

theorem checkRange13_spec {h : ℕ} {C : Cert13} {wt : List ℕ} {lam lo hi chunks : ℕ}
    (hc : C.checkRange13 h wt lam lo hi chunks = true) : ∀ i, lo ≤ i → i < hi → C.rowOK13 h wt lam i = true := by
  intro i hlo hhi
  unfold Cert13.checkRange13 at hc
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
  apply rowsOK13_spec h C wt lam _ _ this i (by omega)
  rw [Nat.min_eq_right (by omega : q * size ≤ cnt)]
  omega

/-- The row test of entry `i`: its bucket is re-checked and `rowOK` holds for its key. -/
theorem rowOK13_spec {h : ℕ} {C : Cert13} {wt : List ℕ} {lam i : ℕ} (hr : C.rowOK13 h wt lam i = true) :
    C.bucketOf i < C.nb ∧ C.tabAt (C.bucketOf i) ≤ i ∧ i < C.tabAt (C.bucketOf i + 1) ∧
      rowOK h C.findVal wt lam (C.keyOf i) (C.valAt i) = true := by
  unfold Cert13.rowOK13 at hr
  simp only [Bool.and_eq_true, decide_eq_true_eq] at hr
  exact ⟨hr.1.1.1, hr.1.1.2, hr.1.2, hr.2⟩

/-! ### Lookups -/

/-- A lookup re-checks the index, the bucket of the code and the low bits. -/
theorem find13_spec {C : Cert13} {t j : ℕ} (hf : C.find t = some j) :
    t >>> C.sb < C.nb ∧ C.tabAt (t >>> C.sb) ≤ j ∧ j < C.tabAt (t >>> C.sb + 1) ∧ j < C.n ∧
      C.lowAt j = t % 2 ^ C.sb := by
  unfold Cert13.find at hf
  simp only [Bool.and_eq_true, decide_eq_true_eq, beq_iff_eq] at hf
  split_ifs at hf with h1 h2
  obtain rfl := Option.some.inj hf
  exact ⟨h1, h2.1.1.1, h2.1.1.2, h2.1.2, h2.2⟩

theorem shiftRight_shiftLeft_or_mod13 (t s : ℕ) : ((t >>> s) <<< s) ||| t % 2 ^ s = t := by
  apply Nat.eq_of_testBit_eq; intro i
  simp only [Nat.testBit_or, Nat.testBit_shiftLeft, Nat.testBit_shiftRight, Nat.testBit_mod_two_pow]
  by_cases hi : s ≤ i
  · simp [hi, show s + (i - s) = i by omega, show ¬ i < s by omega]
  · simp [hi, show i < s by omega]

/-! ### Soundness for one certificate -/

/-- A monotone table, `globalOK` and the row tests of all entries give the hypotheses of `sound_of_rows`. -/
theorem cert13_sound {h : ℕ} (C : Cert13) {wt : List ℕ} {lam : ℕ}
    (hmono : ∀ b < C.nb, C.tabAt b ≤ C.tabAt (b + 1)) (hg : globalOK h C.findVal wt = true)
    (hrows : ∀ i < C.n, C.rowOK13 h wt lam i = true) :
    (∀ t u, C.findVal t = some u → (t, u) ∈ (Finset.range C.n).image fun i => (C.keyOf i, C.valAt i)) ∧
      (∀ e ∈ (Finset.range C.n).image (fun i => (C.keyOf i, C.valAt i)),
        rowOK h C.findVal wt lam e.1 e.2 = true) ∧
      globalOK h C.findVal wt = true := by
  refine ⟨fun t u hf => ?_, fun e he => ?_, hg⟩
  · unfold Cert13.findVal at hf
    cases hj : C.find t with
    | none => rw [hj] at hf; simp at hf
    | some j =>
      rw [hj] at hf
      simp only [Option.map_some, Option.some.injEq] at hf
      obtain ⟨hb, hlo, hhi, hjn, hlow⟩ := find13_spec hj
      obtain ⟨hb', hlo', hhi', -⟩ := rowOK13_spec (hrows j hjn)
      have hbeq : C.bucketOf j = t >>> C.sb := bucket_unique13 hmono hb' hb hlo' hhi' hlo hhi
      refine Finset.mem_image.mpr ⟨j, Finset.mem_range.mpr hjn, ?_⟩
      have hkey : C.keyOf j = t := by
        show (C.bucketOf j <<< C.sb) ||| C.lowAt j = t
        rw [hbeq, hlow]; exact shiftRight_shiftLeft_or_mod13 t C.sb
      rw [hkey, hf]
  · obtain ⟨i, hi, rfl⟩ := Finset.mem_image.mp he
    exact (rowOK13_spec (hrows i (Finset.mem_range.mp hi))).2.2.2

/-! ### Machine shares -/

/-- Machine shares `(lo, hi, chunks)` whose row ranges cover `[0, n)` give the hypotheses of `sound_of_rows` /
`gamma2_le_of_rows` with `find := C.findVal`. -/
theorem checkCert13R_soundR {h : ℕ} {lowCs tabCs vecCs : List (ℕ × ℕ)} {n sb lb nb tb cs : ℕ} {wt : List ℕ}
    {lam : ℕ} (R : List (ℕ × ℕ × ℕ))
    (hR : ∀ r ∈ R, checkCert13R h lowCs tabCs vecCs n sb lb nb tb cs wt lam r.1 r.2.1 r.2.2 = true)
    (r0 : ℕ × ℕ × ℕ) (hr0 : r0 ∈ R) (hcov : ∀ i < n, ∃ r ∈ R, r.1 ≤ i ∧ i < r.2.1) :
    let C : Cert13 := ⟨chunksPar lowCs, chunksPar tabCs, chunksPar vecCs, n, sb, lb, nb, tb, cs⟩
    let E := (Finset.range n).image fun i => (C.keyOf i, C.valAt i)
    (∀ t u, C.findVal t = some u → (t, u) ∈ E) ∧ (∀ e ∈ E, rowOK h C.findVal wt lam e.1 e.2 = true) ∧
      globalOK h C.findVal wt = true := by
  intro C E
  have hg0 := hR r0 hr0
  unfold checkCert13R at hg0
  simp only [Bool.and_eq_true] at hg0
  have hmono : ∀ b < C.nb, C.tabAt b ≤ C.tabAt (b + 1) := tabMono13_spec hg0.1.1
  have hglob : globalOK h C.findVal wt = true := hg0.1.2
  have hrows : ∀ i < C.n, C.rowOK13 h wt lam i = true := by
    intro i hi
    obtain ⟨r, hr, h1, h2⟩ := hcov i hi
    have hc := hR r hr
    unfold checkCert13R at hc
    simp only [Bool.and_eq_true] at hc
    exact checkRange13_spec hc.2 i h1 h2
  exact cert13_sound C hmono hglob hrows

end CS31a

