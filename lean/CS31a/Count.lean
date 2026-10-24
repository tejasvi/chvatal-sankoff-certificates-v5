import CS31a.Fekete
import CS31a.Symm

/-!
# The counting theorem (paper Theorem 4.1 with Lemma 4.2), in the log-free form

`gamma2_le_of_cw_cover`: if `CoverExists h` (paper Lemmas 2.3 and 3.1) and a Collatz–Wielandt vector for `δ_red`
with parameters `z, λ` exists, then `γ₂ ≤ θ` for every `θ > 0` with `λ^θ < (2z)^2`.
-/

open Filter Topology

namespace CS31a

/-! ### Weighted counts of accepted input sequences -/

/-- Weighted count of the input sequences of length `k` accepted from `q` by `M_h`. -/
noncomputable def Gs {h : ℕ} (z : ℝ) : ℕ → State h → ℝ
  | 0, _ => 1
  | k + 1, q => ∑ t ∈ inputs h, ((step q t.1 t.2).map fun q' => wz h z t.2.natAbs * Gs z k q').getD 0

/-- The same for the reduced automaton. -/
noncomputable def Fs {h : ℕ} (z : ℝ) : ℕ → State h → ℝ
  | 0, _ => 1
  | k + 1, q => ∑ t ∈ inputs h, ((stepRed q t.1 t.2).map fun q' => wz h z t.2.natAbs * Fs z k q').getD 0

theorem flip_sum {h : ℕ} (f : Bool × ℤ → ℝ) : ∑ t ∈ inputs h, f (!t.1, t.2) = ∑ t ∈ inputs h, f t := by
  apply Finset.sum_nbij' (fun t => (!t.1, t.2)) (fun t => (!t.1, t.2))
  · intro t ht; simp only [inputs, Finset.mem_product, Finset.mem_univ, true_and] at ht ⊢; exact ht
  · intro t ht; simp only [inputs, Finset.mem_product, Finset.mem_univ, true_and] at ht ⊢; exact ht
  · intro t _; simp
  · intro t _; simp
  · intro t _; rfl

theorem compl_compl {h : ℕ} (q : State h) : q.compl.compl = q := by
  ext t <;> simp [State.compl]

theorem rep_compl {h : ℕ} (q : State h) : rep q.compl = rep q := by
  unfold rep
  by_cases h0 : 0 < h
  · rw [dif_pos h0, dif_pos h0]
    have hc : q.compl.x ⟨0, h0⟩ = !q.x ⟨0, h0⟩ := rfl
    cases hx : q.x ⟨0, h0⟩ <;> simp [hc, hx, compl_compl]
  · rw [dif_neg h0, dif_neg h0]
    ext t <;> exact absurd t.2 (by omega)

theorem rep_cases {h : ℕ} (q : State h) : rep q = q ∨ rep q = q.compl := by
  unfold rep; split_ifs <;> simp

theorem Gs_eq_Fs_rep {h : ℕ} (z : ℝ) : ∀ (k : ℕ) (q : State h), Gs z k q = Fs z k (rep q) := by
  intro k
  induction k with
  | zero => intro q; rfl
  | succ k ih =>
    intro q
    have hG : Gs z (k + 1) q = ∑ t ∈ inputs h,
        ((step q t.1 t.2).map fun q' => wz h z t.2.natAbs * Fs z k (rep q')).getD 0 := by
      simp only [Gs, ih]
    have hF : ∀ r : State h, Fs z (k + 1) r = ∑ t ∈ inputs h,
        ((step r t.1 t.2).map fun q' => wz h z t.2.natAbs * Fs z k (rep q')).getD 0 := by
      intro r; simp only [Fs, stepRed, Option.map_map, Function.comp_def]
    rw [hG, hF]
    rcases rep_cases q with hr | hr
    · rw [hr]
    · rw [hr, ← flip_sum]
      apply Finset.sum_congr rfl
      intro t _
      have e : step q.compl t.1 t.2 = (step q (!t.1) t.2).map State.compl := by
        have := step_compl q (!t.1) t.2; rwa [Bool.not_not] at this
      rw [e, Option.map_map]
      simp only [Function.comp_def, rep_compl]

/-- The Collatz–Wielandt bound on the reduced counts. -/
theorem Fs_le {h : ℕ} {z lam : ℝ} (hz0 : 0 ≤ z) (hz1 : z < 1) {S : Finset (State h)} (hS : ClosedRed S)
    {v : State h → ℝ} (hv : ∀ q ∈ S, 0 < v q) (hcw : ∀ q ∈ S, cwSum h z v q ≤ lam * v q) (hlam : 0 ≤ lam) :
    ∀ (k : ℕ), ∀ r ∈ S, Fs z k r ≤ lam ^ k * v r / S.inf' ⟨q0 h, hS.1⟩ v := by
  have hwz : ∀ k, 0 ≤ wz h z k := by
    intro k; unfold wz; split_ifs
    · positivity
    · exact div_nonneg (pow_nonneg hz0 _) (by linarith)
  set m := S.inf' ⟨q0 h, hS.1⟩ v with hm
  have hmpos : 0 < m := by
    obtain ⟨q, hq, hqm⟩ := Finset.exists_mem_eq_inf' ⟨q0 h, hS.1⟩ v
    rw [hm, hqm]; exact hv q hq
  intro k
  induction k with
  | zero =>
    intro r hr
    simp only [Fs, pow_zero, one_mul]
    rw [le_div_iff₀ hmpos, one_mul]
    exact Finset.inf'_le _ hr
  | succ k ih =>
    intro r hr
    simp only [Fs]
    calc ∑ t ∈ inputs h, ((stepRed r t.1 t.2).map fun q' => wz h z t.2.natAbs * Fs z k q').getD 0
        ≤ ∑ t ∈ inputs h, ((stepRed r t.1 t.2).map fun q' => wz h z t.2.natAbs * (lam ^ k * v q' / m)).getD 0 := by
          apply Finset.sum_le_sum
          intro t ht
          cases hs : stepRed r t.1 t.2 with
          | none => simp
          | some q' =>
            simp only [Option.map_some, Option.getD_some]
            exact mul_le_mul_of_nonneg_left (ih q' (hS.2 r hr t ht q' hs)) (hwz _)
      _ = lam ^ k / m * cwSum h z v r := by
          unfold cwSum
          rw [Finset.mul_sum]
          apply Finset.sum_congr rfl
          intro t _
          cases stepRed r t.1 t.2 with
          | none => simp
          | some q' => simp only [Option.map_some, Option.getD_some]; ring
      _ ≤ lam ^ k / m * (lam * v r) := by
          apply mul_le_mul_of_nonneg_left (hcw r hr); positivity
      _ = lam ^ (k + 1) * v r / m := by ring

/-! ### Counting pairs of strings with an accepted decomposition -/

/-- All lists of length `a`. -/
def lists (a : ℕ) : Finset (List Bool) := (Finset.univ : Finset (Fin a → Bool)).image List.ofFn

theorem mem_lists {a : ℕ} {A : List Bool} : A ∈ lists a ↔ A.length = a := by
  unfold lists
  constructor
  · intro hA; obtain ⟨f, -, rfl⟩ := Finset.mem_image.mp hA; simp
  · intro hA; subst hA; exact Finset.mem_image.mpr ⟨fun i => A.get i, Finset.mem_univ _, List.ofFn_get A⟩

theorem card_lists (a : ℕ) : (lists a).card = 2 ^ a := by
  unfold lists
  rw [Finset.card_image_of_injective _ List.ofFn_injective]; simp

/-- The pairs of lists of lengths `a`, `b` that begin with `k` minimal match pairs accepted from `q`. -/
noncomputable def Dset (h : ℕ) (q : State h) (k a b : ℕ) : Finset (List Bool × List Bool) := by
  classical exact ((lists a) ×ˢ (lists b)).filter fun AB => HasDecomp h q k AB.1 AB.2

/-- The minimal match pairs `T_{c,l}` that fit into lengths `a`, `b`. -/
def pairsFit (a b : ℕ) : Finset (Bool × ℤ) :=
  (Finset.univ ×ˢ Finset.Icc (-(b : ℤ)) a).filter fun p => (T p.1 p.2).1.length ≤ a ∧ (T p.1 p.2).2.length ≤ b

theorem T_size (c : Bool) (l : ℤ) : (T c l).1.length + (T c l).2.length = l.natAbs + 2 := by
  unfold T; split_ifs with hl <;> simp <;> omega

theorem T_len1 (c : Bool) (l : ℤ) : (T c l).1.length = if 0 ≤ l then l.toNat + 1 else 1 := by
  unfold T; split_ifs <;> simp

theorem T_len2 (c : Bool) (l : ℤ) : (T c l).2.length = if 0 ≤ l then 1 else l.natAbs + 1 := by
  unfold T; split_ifs <;> simp

theorem strA_cons (p : Bool × ℤ) (ps : List (Bool × ℤ)) : strA (p :: ps) = (T p.1 p.2).1 ++ strA ps := by
  simp [strA]

theorem strB_cons (p : Bool × ℤ) (ps : List (Bool × ℤ)) : strB (p :: ps) = (T p.1 p.2).2 ++ strB ps := by
  simp [strB]

theorem hasDecomp_succ {h : ℕ} {q : State h} {k : ℕ} {A B : List Bool} (hd : HasDecomp h q (k + 1) A B) :
    ∃ p : Bool × ℤ, ∃ q' : State h, step q (trunc h p).1 (trunc h p).2 = some q' ∧
      ∃ A₁ B₁, A = (T p.1 p.2).1 ++ A₁ ∧ B = (T p.1 p.2).2 ++ B₁ ∧ HasDecomp h q' k A₁ B₁ := by
  obtain ⟨ps, hlen, hrun, A', B', hA, hB⟩ := hd
  obtain ⟨p, ps', rfl⟩ : ∃ p ps', ps = p :: ps' := by
    cases ps with
    | nil => simp at hlen
    | cons p ps' => exact ⟨p, ps', rfl⟩
  simp only [List.map_cons, runM] at hrun
  cases hs : step q (trunc h p).1 (trunc h p).2 with
  | none => rw [hs] at hrun; simp at hrun
  | some q' =>
    rw [hs] at hrun
    refine ⟨p, q', hs, strA ps' ++ A', strB ps' ++ B', by rw [hA, strA_cons, List.append_assoc],
      by rw [hB, strB_cons, List.append_assoc], ps', by simpa using hlen, by simpa using hrun, A', B', rfl, rfl⟩

theorem trunc_mem_inputs {h : ℕ} (hh : 2 ≤ h) (p : Bool × ℤ) : trunc h p ∈ inputs h := by
  simp only [trunc, inputs, Finset.mem_product, Finset.mem_univ, Finset.mem_Icc, true_and, min_def, max_def]
  split_ifs <;> omega

/-- The weight of the minimal match pairs that truncate to an input. -/
theorem fiber_le {h : ℕ} (hh : 2 ≤ h) {z : ℝ} (hz0 : 0 < z) (hz1 : z < 1) (a b : ℕ) (t : Bool × ℤ)
    (ht : t ∈ inputs h) :
    ∑ p ∈ (pairsFit a b).filter (fun p => trunc h p = t),
      z ^ ((T p.1 p.2).1.length + (T p.1 p.2).2.length) ≤ wz h z t.2.natAbs := by
  obtain ⟨c, l⟩ := t
  simp only [inputs, Finset.mem_product, Finset.mem_univ, Finset.mem_Icc, true_and] at ht
  simp only [T_size]
  unfold wz
  split_ifs with hl
  · -- |l| < h - 1: the only preimage is (c, l)
    calc ∑ p ∈ (pairsFit a b).filter (fun p => trunc h p = (c, l)), z ^ (p.2.natAbs + 2)
        ≤ ∑ p ∈ ({(c, l)} : Finset (Bool × ℤ)), z ^ (p.2.natAbs + 2) := by
          apply Finset.sum_le_sum_of_subset_of_nonneg
          · intro p hp
            simp only [Finset.mem_filter, trunc, Prod.mk.injEq] at hp
            obtain ⟨-, h1, h2⟩ := hp
            simp only [Finset.mem_singleton, Prod.ext_iff]
            refine ⟨h1, ?_⟩
            simp only [min_def, max_def] at h2
            split_ifs at h2 <;> omega
          · intro _ _ _; positivity
      _ = z ^ (l.natAbs + 2) := by simp
  · -- |l| = h - 1: the preimages have the sign of `l` and `|l'| ≥ h - 1`
    have hl' : l.natAbs + 1 = h := by omega
    calc ∑ p ∈ (pairsFit a b).filter (fun p => trunc h p = (c, l)), z ^ (p.2.natAbs + 2)
        = ∑ j ∈ ((pairsFit a b).filter (fun p => trunc h p = (c, l))).image (fun p => p.2.natAbs),
            z ^ (j + 2) := by
          rw [Finset.sum_image]
          intro p hp p' hp' he
          simp only [Finset.coe_filter, Set.mem_setOf_eq, trunc, Prod.mk.injEq] at hp hp'
          obtain ⟨-, hc, hp2⟩ := hp; obtain ⟨-, hc', hp2'⟩ := hp'
          simp only at he
          apply Prod.ext (hc.trans hc'.symm)
          simp only [min_def, max_def] at hp2 hp2'
          split_ifs at hp2 hp2' <;> omega
      _ ≤ ∑ j ∈ Finset.Ico (h - 1) (a + b + 1), z ^ (j + 2) := by
          apply Finset.sum_le_sum_of_subset_of_nonneg
          · intro j hj
            simp only [Finset.mem_image, Finset.mem_filter, pairsFit, Finset.mem_product, Finset.mem_univ,
              Finset.mem_Icc, true_and, trunc, Prod.mk.injEq] at hj
            obtain ⟨p, ⟨⟨⟨h1, h2⟩, -⟩, -, h3⟩, rfl⟩ := hj
            simp only [Finset.mem_Ico]
            simp only [min_def, max_def] at h3
            split_ifs at h3 <;> omega
          · intro _ _ _; positivity
      _ = z ^ 2 * ∑ j ∈ Finset.Ico (h - 1) (a + b + 1), z ^ j := by
          rw [Finset.mul_sum]; apply Finset.sum_congr rfl; intro j _; ring
      _ ≤ z ^ 2 * (z ^ (h - 1) / (1 - z)) := by
          apply mul_le_mul_of_nonneg_left (geom_sum_Ico_le_of_lt_one hz0.le hz1) (by positivity)
      _ = z ^ (h + 1) / (1 - z) := by
          rw [mul_div_assoc', ← pow_add]; congr 2; omega

theorem sum_pairs_le {h : ℕ} (hh : 2 ≤ h) {z : ℝ} (hz0 : 0 < z) (hz1 : z < 1) (a b : ℕ) (F : Bool × ℤ → ℝ)
    (hF : ∀ t, 0 ≤ F t) :
    ∑ p ∈ pairsFit a b, z ^ ((T p.1 p.2).1.length + (T p.1 p.2).2.length) * F (trunc h p) ≤
      ∑ t ∈ inputs h, wz h z t.2.natAbs * F t := by
  classical
  rw [← Finset.sum_fiberwise_of_maps_to (s := pairsFit a b) (t := inputs h) (g := trunc h)
    (fun p _ => trunc_mem_inputs hh p)]
  apply Finset.sum_le_sum
  intro t ht
  calc ∑ p ∈ (pairsFit a b).filter (fun p => trunc h p = t),
        z ^ ((T p.1 p.2).1.length + (T p.1 p.2).2.length) * F (trunc h p)
      = (∑ p ∈ (pairsFit a b).filter (fun p => trunc h p = t),
          z ^ ((T p.1 p.2).1.length + (T p.1 p.2).2.length)) * F t := by
        rw [Finset.sum_mul]; apply Finset.sum_congr rfl; intro p hp
        rw [(Finset.mem_filter.mp hp).2]
    _ ≤ wz h z t.2.natAbs * F t := mul_le_mul_of_nonneg_right (fiber_le hh hz0 hz1 a b t ht) (hF t)

theorem Gs_nonneg {h : ℕ} {z : ℝ} (hz0 : 0 ≤ z) (hz1 : z < 1) : ∀ k (q : State h), 0 ≤ Gs z k q := by
  have hwz : ∀ k, 0 ≤ wz h z k := by
    intro k; unfold wz; split_ifs
    · positivity
    · exact div_nonneg (pow_nonneg hz0 _) (by linarith)
  intro k
  induction k with
  | zero => intro q; simp [Gs]
  | succ k ih =>
    intro q; simp only [Gs]
    apply Finset.sum_nonneg; intro t _
    cases step q t.1 t.2 with
    | none => simp
    | some q' => simp only [Option.map_some, Option.getD_some]; exact mul_nonneg (hwz _) (ih q')

/-- The counting bound: `#{(A, B) : |A| = a, |B| = b, k accepted pairs from q} ≤ z^{-(a+b)} G_k(q)`. -/
theorem card_Dset_le {h : ℕ} (hh : 2 ≤ h) {z : ℝ} (hz0 : 0 < z) (hz1 : z < 1 / 2) :
    ∀ (k a b : ℕ) (q : State h), ((Dset h q k a b).card : ℝ) ≤ z⁻¹ ^ (a + b) * Gs z k q := by
  have hz1' : z < 1 := by linarith
  intro k
  induction k with
  | zero =>
    intro a b q
    classical
    simp only [Gs, mul_one]
    calc ((Dset h q 0 a b).card : ℝ) ≤ ((lists a ×ˢ lists b).card : ℝ) := by
          unfold Dset; exact_mod_cast Finset.card_le_card (Finset.filter_subset _ _)
      _ = 2 ^ (a + b) := by rw [Finset.card_product, card_lists, card_lists]; push_cast; ring
      _ ≤ z⁻¹ ^ (a + b) := by
          apply pow_le_pow_left₀ (by norm_num)
          rw [le_inv_comm₀ (by norm_num) hz0]; linarith
  | succ k ih =>
    intro a b q
    classical
    set img : Bool × ℤ → Finset (List Bool × List Bool) := fun p =>
      match step q (trunc h p).1 (trunc h p).2 with
      | none => ∅
      | some q' => (Dset h q' k (a - (T p.1 p.2).1.length) (b - (T p.1 p.2).2.length)).image
          (fun AB => ((T p.1 p.2).1 ++ AB.1, (T p.1 p.2).2 ++ AB.2)) with himg
    have hsub : Dset h q (k + 1) a b ⊆ (pairsFit a b).biUnion img := by
      intro AB hAB
      unfold Dset at hAB
      simp only [Finset.mem_filter, Finset.mem_product, mem_lists] at hAB
      obtain ⟨⟨hA, hB⟩, hd⟩ := hAB
      obtain ⟨p, q', hstep, A₁, B₁, hA₁, hB₁, hd₁⟩ := hasDecomp_succ hd
      have h1 : (T p.1 p.2).1.length ≤ a := by rw [← hA, hA₁, List.length_append]; omega
      have h2 : (T p.1 p.2).2.length ≤ b := by rw [← hB, hB₁, List.length_append]; omega
      refine Finset.mem_biUnion.mpr ⟨p, ?_, ?_⟩
      · simp only [pairsFit, Finset.mem_filter, Finset.mem_product, Finset.mem_univ, Finset.mem_Icc, true_and]
        refine ⟨?_, h1, h2⟩
        rw [T_len1] at h1; rw [T_len2] at h2
        split_ifs at h1 h2 <;> omega
      · simp only [himg, hstep]
        refine Finset.mem_image.mpr ⟨(A₁, B₁), ?_, ?_⟩
        · unfold Dset
          simp only [Finset.mem_filter, Finset.mem_product, mem_lists]
          refine ⟨⟨?_, ?_⟩, hd₁⟩
          · rw [← hA, hA₁, List.length_append]; omega
          · rw [← hB, hB₁, List.length_append]; omega
        · exact Prod.ext (by simp [hA₁]) (by simp [hB₁])
    set F : Bool × ℤ → ℝ := fun t => ((step q t.1 t.2).map fun q' => Gs z k q').getD 0 with hF
    have hFnn : ∀ t, 0 ≤ F t := by
      intro t; simp only [hF]
      cases step q t.1 t.2 with
      | none => simp
      | some q' => simpa using Gs_nonneg hz0.le hz1' k q'
    calc ((Dset h q (k + 1) a b).card : ℝ)
        ≤ (((pairsFit a b).biUnion img).card : ℝ) := by exact_mod_cast Finset.card_le_card hsub
      _ ≤ ∑ p ∈ pairsFit a b, ((img p).card : ℝ) := by exact_mod_cast Finset.card_biUnion_le
      _ ≤ ∑ p ∈ pairsFit a b, z⁻¹ ^ (a + b) * (z ^ ((T p.1 p.2).1.length + (T p.1 p.2).2.length) *
            F (trunc h p)) := by
          apply Finset.sum_le_sum
          intro p hp
          simp only [pairsFit, Finset.mem_filter] at hp
          obtain ⟨-, h1, h2⟩ := hp
          simp only [himg, hF]
          cases hs : step q (trunc h p).1 (trunc h p).2 with
          | none => simp
          | some q' =>
            simp only [Option.map_some, Option.getD_some]
            calc (((Dset h q' k (a - (T p.1 p.2).1.length) (b - (T p.1 p.2).2.length)).image
                    (fun AB => ((T p.1 p.2).1 ++ AB.1, (T p.1 p.2).2 ++ AB.2))).card : ℝ)
                ≤ ((Dset h q' k (a - (T p.1 p.2).1.length) (b - (T p.1 p.2).2.length)).card : ℝ) := by
                  exact_mod_cast Finset.card_image_le
              _ ≤ z⁻¹ ^ ((a - (T p.1 p.2).1.length) + (b - (T p.1 p.2).2.length)) * Gs z k q' := ih _ _ q'
              _ = z⁻¹ ^ (a + b) * (z ^ ((T p.1 p.2).1.length + (T p.1 p.2).2.length) * Gs z k q') := by
                  set A' := a - (T p.1 p.2).1.length
                  set B' := b - (T p.1 p.2).2.length
                  set sp := (T p.1 p.2).1.length + (T p.1 p.2).2.length
                  have e : a + b = (A' + B') + sp := by omega
                  have hs : z⁻¹ ^ sp * z ^ sp = 1 := by rw [inv_pow, inv_mul_cancel₀ (pow_ne_zero _ hz0.ne')]
                  calc z⁻¹ ^ (A' + B') * Gs z k q' = z⁻¹ ^ (A' + B') * (z⁻¹ ^ sp * z ^ sp) * Gs z k q' := by
                        rw [hs, mul_one]
                    _ = z⁻¹ ^ ((A' + B') + sp) * (z ^ sp * Gs z k q') := by rw [pow_add]; ring
                    _ = z⁻¹ ^ (a + b) * (z ^ sp * Gs z k q') := by rw [← e]
      _ = z⁻¹ ^ (a + b) * ∑ p ∈ pairsFit a b, z ^ ((T p.1 p.2).1.length + (T p.1 p.2).2.length) *
            F (trunc h p) := by rw [Finset.mul_sum]
      _ ≤ z⁻¹ ^ (a + b) * ∑ t ∈ inputs h, wz h z t.2.natAbs * F t := by
          apply mul_le_mul_of_nonneg_left (sum_pairs_le hh hz0 hz1' a b F hFnn) (by positivity)
      _ = z⁻¹ ^ (a + b) * Gs z (k + 1) q := by
          congr 1
          simp only [Gs, hF]
          apply Finset.sum_congr rfl; intro t _
          cases step q t.1 t.2 <;> simp

/-! ### From the counts to `γ₂ ≤ θ` -/

theorem rep_q0 {h : ℕ} (hh : 1 ≤ h) : rep (q0 h) = q0 h := by
  unfold rep; rw [dif_pos (by omega)]; simp [q0]

/-- Pairs of strings of length `n` with `LCS ≥ k` are at most the pairs with `k` accepted pairs (`CoverExists`). -/
theorem card_lcs_ge_le {h : ℕ} (hh : 2 ≤ h) (Hc : CoverExists h) (n k : ℕ) :
    ((Finset.univ.filter (fun AB : (Fin n → Bool) × (Fin n → Bool) =>
        k ≤ lcsLen (List.ofFn AB.1) (List.ofFn AB.2))).card : ℝ) ≤ (Dset h (q0 h) k n n).card := by
  classical
  exact_mod_cast Finset.card_le_card_of_injOn
    (fun AB : (Fin n → Bool) × (Fin n → Bool) => (List.ofFn AB.1, List.ofFn AB.2))
    (fun AB hAB => by
      simp only [Finset.coe_filter, Finset.mem_univ, true_and, Set.mem_setOf_eq] at hAB
      unfold Dset
      simp only [Finset.coe_filter, Finset.mem_product, mem_lists, List.length_ofFn, true_and,
        Set.mem_setOf_eq]
      exact Hc hh _ _ (by simp) k hAB)
    (fun AB _ AB' _ he => by
      simp only [Prod.mk.injEq] at he
      exact Prod.ext (List.ofFn_injective he.1) (List.ofFn_injective he.2))

/-- The sum of `LCS` over pairs, split at `k ≥ 1`. -/
theorem sumLCS_le_split (n k : ℕ) (hk : 1 ≤ k) :
    sumLCS n ≤ 4 ^ n * ((k : ℝ) - 1) + n * ((Finset.univ.filter (fun AB : (Fin n → Bool) × (Fin n → Bool) =>
        k ≤ lcsLen (List.ofFn AB.1) (List.ofFn AB.2))).card : ℝ) := by
  classical
  unfold sumLCS
  rw [← Fintype.sum_prod_type (fun AB : (Fin n → Bool) × (Fin n → Bool) =>
    (lcsLen (List.ofFn AB.1) (List.ofFn AB.2) : ℝ))]
  calc ∑ AB : (Fin n → Bool) × (Fin n → Bool), (lcsLen (List.ofFn AB.1) (List.ofFn AB.2) : ℝ)
      ≤ ∑ AB : (Fin n → Bool) × (Fin n → Bool), (((k : ℝ) - 1) +
          n * (if k ≤ lcsLen (List.ofFn AB.1) (List.ofFn AB.2) then 1 else 0)) := by
        apply Finset.sum_le_sum
        intro AB _
        have hL := lcsLen_le_left (List.ofFn AB.1) (List.ofFn AB.2)
        rw [List.length_ofFn] at hL
        split_ifs with hkL
        · have : (lcsLen (List.ofFn AB.1) (List.ofFn AB.2) : ℝ) ≤ n := by exact_mod_cast hL
          have : (1 : ℝ) ≤ k := by exact_mod_cast hk
          linarith
        · push_neg at hkL
          have : (lcsLen (List.ofFn AB.1) (List.ofFn AB.2) : ℝ) + 1 ≤ k := by exact_mod_cast hkL
          linarith
    _ = 4 ^ n * ((k : ℝ) - 1) + n * ((Finset.univ.filter (fun AB : (Fin n → Bool) × (Fin n → Bool) =>
          k ≤ lcsLen (List.ofFn AB.1) (List.ofFn AB.2))).card : ℝ) := by
        rw [Finset.sum_add_distrib, Finset.sum_const, Finset.card_univ, ← Finset.mul_sum, Finset.sum_boole]
        simp only [Fintype.card_prod, Fintype.card_fun, Fintype.card_bool, Fintype.card_fin, nsmul_eq_mul]
        push_cast; rw [show (4 : ℝ) = 2 * 2 by norm_num, mul_pow]

/-- Paper Theorem 4.1 with Lemma 4.2, in the log-free form, assuming `CoverExists h`. -/
theorem gamma2_le_of_cw_cover {h : ℕ} (hh : 2 ≤ h) (Hc : CoverExists h) {z lam θ : ℝ} (hz : 0 < z)
    (hz2 : z < 1 / 2) (hlam : 0 < lam) (hθ : 0 < θ) (hρ : lam ^ θ < (2 * z) ^ 2)
    (S : Finset (State h)) (hS : ClosedRed S) (v : State h → ℝ) (hv : ∀ q ∈ S, 0 < v q)
    (hcw : ∀ q ∈ S, cwSum h z v q ≤ lam * v q) : gamma2 ≤ θ := by
  have hz1 : z < 1 := by linarith
  have h2z : (2 * z) ^ 2 < 1 := by nlinarith
  have hlam1 : lam < 1 := by
    by_contra hge; push_neg at hge
    have : 1 ≤ lam ^ θ := Real.one_le_rpow hge hθ.le
    linarith
  set m := S.inf' ⟨q0 h, hS.1⟩ v with hm
  have hmpos : 0 < m := by
    obtain ⟨q, hq, hqm⟩ := Finset.exists_mem_eq_inf' ⟨q0 h, hS.1⟩ v
    rw [hm, hqm]; exact hv q hq
  set C0 := v (q0 h) / m with hC0
  have hC0nn : 0 ≤ C0 := div_nonneg (hv _ hS.1).le hmpos.le
  set ρ := lam ^ θ / (2 * z) ^ 2 with hρdef
  have hρ0 : 0 ≤ ρ := div_nonneg (Real.rpow_nonneg hlam.le _) (by positivity)
  have hρ1 : ρ < 1 := by rw [hρdef, div_lt_one (by positivity)]; exact hρ
  -- the bound for every n
  have hbound : ∀ n : ℕ, expLCS n / n ≤ θ + C0 * ρ ^ n := by
    intro n
    rcases Nat.eq_zero_or_pos n with rfl | hn
    · simp only [CharP.cast_eq_zero, div_zero, pow_zero, mul_one]; linarith
    have hnR : (0 : ℝ) < n := by exact_mod_cast hn
    set k := ⌈θ * n⌉₊ with hk
    have hk1 : 1 ≤ k := by
      rw [hk, Nat.one_le_ceil_iff]; positivity
    have hk2 : (k : ℝ) < θ * n + 1 := Nat.ceil_lt_add_one (by positivity)
    have hk3 : θ * n ≤ k := Nat.le_ceil _
    have hX := card_lcs_ge_le hh Hc n k
    have hD := card_Dset_le hh hz hz2 k n n (q0 h)
    have hG : Gs z k (q0 h) ≤ lam ^ k * v (q0 h) / m := by
      rw [Gs_eq_Fs_rep, rep_q0 (by omega)]
      exact Fs_le hz.le hz1 hS hv hcw hlam.le k (q0 h) hS.1
    have hsum := sumLCS_le_split n k hk1
    have hpow : lam ^ k ≤ (lam ^ θ) ^ n := by
      rw [← Real.rpow_natCast, ← Real.rpow_natCast, ← Real.rpow_mul hlam.le]
      exact Real.rpow_le_rpow_of_exponent_ge hlam hlam1.le hk3
    -- assemble
    have key : expLCS n ≤ θ * n + n * (C0 * ρ ^ n) := by
      rw [expLCS_eq, div_le_iff₀ (by positivity)]
      have e1 : z⁻¹ ^ (n + n) * (lam ^ k * v (q0 h) / m) ≤ z⁻¹ ^ (n + n) * ((lam ^ θ) ^ n * C0) := by
        apply mul_le_mul_of_nonneg_left _ (by positivity)
        rw [hC0, mul_div_assoc]
        exact mul_le_mul_of_nonneg_right hpow (div_nonneg (hv _ hS.1).le hmpos.le)
      have e2 : z⁻¹ ^ (n + n) * ((lam ^ θ) ^ n * C0) = 4 ^ n * (C0 * ρ ^ n) := by
        have h4 : ((2 * z) ^ 2) ^ n = 4 ^ n * z ^ (n + n) := by
          rw [← pow_mul, mul_pow, show n + n = 2 * n by ring, pow_mul, pow_mul]; norm_num
        rw [hρdef, div_pow, h4, inv_pow]
        field_simp
      have hGnn : 0 ≤ Gs z k (q0 h) := Gs_nonneg hz.le hz1 k (q0 h)
      calc sumLCS n ≤ 4 ^ n * ((k : ℝ) - 1) + n * ((Finset.univ.filter (fun AB : (Fin n → Bool) × (Fin n → Bool) =>
            k ≤ lcsLen (List.ofFn AB.1) (List.ofFn AB.2))).card : ℝ) := hsum
        _ ≤ 4 ^ n * (θ * n) + n * (z⁻¹ ^ (n + n) * (lam ^ k * v (q0 h) / m)) := by
            apply add_le_add
            · apply mul_le_mul_of_nonneg_left (by linarith) (by positivity)
            · apply mul_le_mul_of_nonneg_left _ hnR.le
              calc _ ≤ ((Dset h (q0 h) k n n).card : ℝ) := hX
                _ ≤ z⁻¹ ^ (n + n) * Gs z k (q0 h) := hD
                _ ≤ _ := mul_le_mul_of_nonneg_left hG (by positivity)
        _ ≤ 4 ^ n * (θ * n) + n * (4 ^ n * (C0 * ρ ^ n)) := by
            rw [← e2]; exact add_le_add le_rfl (mul_le_mul_of_nonneg_left e1 hnR.le)
        _ = (θ * n + n * (C0 * ρ ^ n)) * 4 ^ n := by ring
    rw [div_le_iff₀ hnR]
    nlinarith [key]
  -- the limit
  have hlim : Tendsto (fun n : ℕ => θ + C0 * ρ ^ n) atTop (𝓝 (θ + C0 * 0)) :=
    tendsto_const_nhds.add ((tendsto_pow_atTop_nhds_zero_of_lt_one hρ0 hρ1).const_mul C0)
  have := le_of_tendsto_of_tendsto' tendsto_expLCS_div hlim hbound
  simpa using this

/-- `CoverExists h` implies the interim hypothesis `LuekerCriterion h`. -/
theorem luekerCriterion_of_cover {h : ℕ} (Hc : CoverExists h) : LuekerCriterion h :=
  fun hh _z _lam _θ hz hz2 hlam hθ hρ S hS v hv hcw =>
    gamma2_le_of_cw_cover hh Hc hz hz2 hlam hθ hρ S hS v hv hcw

end CS31a
