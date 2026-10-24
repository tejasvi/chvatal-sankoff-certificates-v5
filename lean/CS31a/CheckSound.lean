import CS31a.Fast
import CS31aCert.Row

/-!
# Soundness of the row test

From `rowOK` on every entry of a finite set `E` of (code, value bits) and `globalOK`, with a lookup `find` that only
returns entries of `E`, we get the hypotheses of the counting theorem: `S = decode(E)` contains `q₀`, is closed
under `δ_red`, `v = val ∘ find ∘ encode` is positive on `S`, and `Σ_p wt[|l|] v(δ_red(q,p)) ≤ lam · v(q)`.
-/

namespace CS31a

open CS31aCert

/-- The real value of the double with bits `u` (positive normal bits). -/
noncomputable def dval (u : ℕ) : ℝ := (dmant u : ℝ) * (2 : ℝ) ^ ((dexp u : ℤ) - 1075)

theorem dval_pos (u : ℕ) : 0 < dval u := by
  unfold dval dmant; positivity

/-- The vector defined by a lookup. -/
noncomputable def vOf (find : ℕ → Option ℕ) (k : ℕ) : ℝ := ((find k).map dval).getD 1

theorem vOf_pos (find : ℕ → Option ℕ) (k : ℕ) : 0 < vOf find k := by
  unfold vOf; cases find k <;> simp [dval_pos]

theorem vOf_some {find : ℕ → Option ℕ} {k u : ℕ} (h : find k = some u) : vOf find k = dval u := by
  simp [vOf, h]

/-! ### The list of inputs -/

theorem mem_inputList {h : ℕ} (hh : 1 ≤ h) (p : Bool × ℤ) : p ∈ inputList h ↔ p ∈ inputs h := by
  obtain ⟨c, l⟩ := p
  simp only [inputList, inputs, List.mem_flatMap, List.mem_map, List.mem_range, Finset.mem_product,
    Finset.mem_univ, Finset.mem_Icc, true_and, Prod.mk.injEq, List.mem_cons, List.not_mem_nil, or_false]
  constructor
  · rintro ⟨c', -, i, hi, rfl, rfl⟩; omega
  · rintro ⟨h1, h2⟩
    refine ⟨c, by cases c <;> simp, (l + (h - 1)).toNat, by omega, rfl, by omega⟩

theorem nodup_inputList (h : ℕ) : (inputList h).Nodup := by
  unfold inputList
  rw [List.nodup_flatMap, List.pairwise_pair]
  refine ⟨fun c _ => (List.nodup_range).map (fun i j hij => by simp at hij; omega), ?_⟩
  simp only [Function.onFun, List.disjoint_left, List.mem_map]
  rintro _ ⟨i, -, rfl⟩ ⟨j, -, hj⟩
  simp at hj

theorem sum_inputs_eq {h : ℕ} (hh : 1 ≤ h) (f : Bool × ℤ → ℝ) :
    ∑ p ∈ inputs h, f p = ((inputList h).map f).sum := by
  have : inputs h = (inputList h).toFinset := by ext p; simp [mem_inputList hh]
  rw [this, List.sum_toFinset _ (nodup_inputList h)]

/-! ### `rowTerms` -/

/-- The contribution of input `p` at code `k` with a lookup. -/
noncomputable def contrib (h : ℕ) (find : ℕ → Option ℕ) (wt : List ℕ) (k : ℕ) (p : Bool × ℤ) : ℝ :=
  match stepCode h k p.1 p.2 with
  | none => 0
  | some t => (wt.getD p.2.natAbs 0 : ℝ) * vOf find t

theorem rowTerms_spec (h : ℕ) (find : ℕ → Option ℕ) (wt : List ℕ) (k : ℕ) :
    ∀ (ps : List (Bool × ℤ)) (terms : List (ℕ × ℕ)), rowTerms h find wt k ps = some terms →
      (∀ p ∈ ps, ∀ t, stepCode h k p.1 p.2 = some t → (find t).isSome) ∧
      (terms.map fun x => (x.1 : ℝ) * dval x.2).sum = (ps.map (contrib h find wt k)).sum := by
  intro ps
  induction ps with
  | nil => intro terms ht; simp [rowTerms] at ht; subst ht; simp
  | cons p ps ih =>
    intro terms ht
    obtain ⟨c, l⟩ := p
    simp only [rowTerms] at ht
    cases hs : stepCode h k c l with
    | none =>
      simp only [hs] at ht
      obtain ⟨h1, h2⟩ := ih terms ht
      refine ⟨?_, ?_⟩
      · intro p hp t ht'
        rcases List.mem_cons.mp hp with rfl | hp
        · simp [hs] at ht'
        · exact h1 p hp t ht'
      · simp [h2, contrib, hs]
    | some t =>
      simp only [hs] at ht
      cases hf : find t with
      | none => simp [hf] at ht
      | some u =>
        simp only [hf] at ht
        cases hr : rowTerms h find wt k ps with
        | none => simp [hr] at ht
        | some r =>
          simp only [hr, Option.some.injEq] at ht
          subst ht
          obtain ⟨h1, h2⟩ := ih r hr
          refine ⟨?_, ?_⟩
          · intro p hp t' ht'
            rcases List.mem_cons.mp hp with rfl | hp
            · simp only [hs, Option.some.injEq] at ht'; subst ht'; simp [hf]
            · exact h1 p hp t' ht'
          · simp only [List.map_cons, List.sum_cons, h2, contrib, hs, vOf_some hf]

/-! ### `rowIneq` -/

theorem foldl_min_le {α : Type*} (f : α → ℕ) :
    ∀ (l : List α) (m : ℕ), l.foldl (fun m p => min m (f p)) m ≤ m ∧
      ∀ x ∈ l, l.foldl (fun m p => min m (f p)) m ≤ f x := by
  intro l
  induction l with
  | nil => intro m; simp
  | cons a l ih =>
    intro m
    obtain ⟨h1, h2⟩ := ih (min m (f a))
    simp only [List.foldl_cons, List.mem_cons, forall_eq_or_imp]
    exact ⟨h1.trans (min_le_left _ _), h1.trans (min_le_right _ _), h2⟩

theorem foldl_add_eq {α : Type*} (g : α → ℕ) :
    ∀ (l : List α) (s : ℕ), l.foldl (fun s p => s + g p) s = s + (l.map g).sum := by
  intro l; induction l with
  | nil => intro s; simp
  | cons a l ih => intro s; simp [ih]; ring

theorem shift_val (w u e : ℕ) (hu : e ≤ dexp u) :
    (((w * dmant u) <<< (dexp u - e) : ℕ) : ℝ) * (2 : ℝ) ^ ((e : ℤ) - 1075) = (w : ℝ) * dval u := by
  have h2 : (2 : ℝ) ^ ((dexp u : ℤ) - 1075) = (2 : ℝ) ^ (dexp u - e) * (2 : ℝ) ^ ((e : ℤ) - 1075) := by
    rw [← zpow_natCast, ← zpow_add₀ two_ne_zero]; congr 1; push_cast [Nat.cast_sub hu]; ring
  rw [Nat.shiftLeft_eq, dval, h2]; push_cast; ring

theorem sum_shift_val (e : ℕ) : ∀ ts : List (ℕ × ℕ), (∀ x ∈ ts, e ≤ dexp x.2) →
    (((ts.map fun p => (p.1 * dmant p.2) <<< (dexp p.2 - e)).sum : ℕ) : ℝ) * (2 : ℝ) ^ ((e : ℤ) - 1075) =
      (ts.map fun x => (x.1 : ℝ) * dval x.2).sum := by
  intro ts hts
  induction ts with
  | nil => simp
  | cons a ts ih =>
    rw [List.map_cons, List.sum_cons, Nat.cast_add, add_mul, shift_val _ _ _ (hts a List.mem_cons_self),
      ih (fun x hx => hts x (List.mem_cons_of_mem _ hx)), List.map_cons, List.sum_cons]

theorem rowIneq_sound (lam ui : ℕ) (terms : List (ℕ × ℕ)) (h : rowIneq lam ui terms = true) :
    (terms.map fun x => (x.1 : ℝ) * dval x.2).sum ≤ (lam : ℝ) * dval ui := by
  unfold rowIneq at h
  simp only [Nat.ble_eq] at h
  obtain ⟨hm0, hm⟩ := foldl_min_le (fun p : ℕ × ℕ => dexp p.2) terms (dexp ui)
  rw [foldl_add_eq, zero_add] at h
  have hpos : (0 : ℝ) < (2 : ℝ) ^ (((terms.foldl (fun m p => min m (dexp p.2)) (dexp ui) : ℕ) : ℤ) - 1075) := by
    positivity
  rw [← sum_shift_val _ terms hm, ← shift_val lam ui _ hm0]
  exact mul_le_mul_of_nonneg_right (by exact_mod_cast h) hpos.le

/-! ### The main soundness theorem -/

theorem rowOK_spec {h : ℕ} {find : ℕ → Option ℕ} {wt : List ℕ} {lam k u : ℕ}
    (hr : rowOK h find wt lam k u = true) :
    k < 2 ^ (4 * h) ∧ find k = some u ∧
      ∃ terms, rowTerms h find wt k (inputList h) = some terms ∧ rowIneq lam u terms = true := by
  unfold rowOK at hr
  simp only [Bool.and_eq_true, Nat.blt_eq, beq_iff_eq] at hr
  obtain ⟨⟨⟨hk, hf⟩, -⟩, hm⟩ := hr
  refine ⟨hk, hf, ?_⟩
  cases ht : rowTerms h find wt k (inputList h) with
  | none => rw [ht] at hm; simp at hm
  | some terms => rw [ht] at hm; exact ⟨terms, rfl, hm⟩

theorem globalOK_spec {h : ℕ} {find : ℕ → Option ℕ} {wt : List ℕ} (hg : globalOK h find wt = true) :
    2 ≤ h ∧ wt.length = h ∧ (find (startCode h)).isSome := by
  unfold globalOK at hg
  simp only [Bool.and_eq_true, Nat.ble_eq, beq_iff_eq] at hg
  exact ⟨hg.1.1, hg.1.2, hg.2⟩

/-- Soundness of the row test: the certificate gives a closed set and a Collatz–Wielandt vector. -/
theorem sound_of_rows {h : ℕ} (find : ℕ → Option ℕ) (wt : List ℕ) (lam : ℕ) (E : Finset (ℕ × ℕ))
    (hfind : ∀ t u, find t = some u → (t, u) ∈ E)
    (hrows : ∀ e ∈ E, rowOK h find wt lam e.1 e.2 = true)
    (hglob : globalOK h find wt = true) :
    ClosedRed (E.image fun e => decode h e.1) ∧
    (∀ q ∈ E.image (fun e => decode h e.1), 0 < vOf find (encode q)) ∧
    ∀ q ∈ E.image (fun e => decode h e.1),
      ∑ p ∈ inputs h, ((stepRed q p.1 p.2).map fun q' =>
          (wt.getD p.2.natAbs 0 : ℝ) * vOf find (encode q')).getD 0 ≤ (lam : ℝ) * vOf find (encode q) := by
  obtain ⟨hh, -, hst⟩ := globalOK_spec hglob
  have hh1 : 1 ≤ h := by omega
  -- every state of S comes from a row that passes
  have hS : ∀ q ∈ E.image (fun e => decode h e.1), ∃ u, find (encode q) = some u ∧
      ∃ terms, rowTerms h find wt (encode q) (inputList h) = some terms ∧ rowIneq lam u terms = true := by
    intro q hq
    obtain ⟨e, he, rfl⟩ := Finset.mem_image.mp hq
    obtain ⟨hk, hf, terms, ht, hi⟩ := rowOK_spec (hrows e he)
    rw [encode_decode h e.1 hk]
    exact ⟨e.2, hf, terms, ht, hi⟩
  -- the contribution of an input, in terms of the code
  have hcontrib : ∀ q : State h, ∀ p : Bool × ℤ,
      ((stepRed q p.1 p.2).map fun q' => (wt.getD p.2.natAbs 0 : ℝ) * vOf find (encode q')).getD 0 =
        contrib h find wt (encode q) p := by
    intro q p
    unfold contrib
    rw [stepCode_encode hh1]
    cases stepRed q p.1 p.2 <;> rfl
  refine ⟨⟨?_, ?_⟩, ?_, ?_⟩
  · -- the start state
    obtain ⟨u0, hu0⟩ := Option.isSome_iff_exists.mp hst
    refine Finset.mem_image.mpr ⟨(startCode h, u0), hfind _ _ hu0, ?_⟩
    simp only
    rw [← encode_q0, decode_encode]
  · -- closure
    intro q hq p hp q' hq'
    obtain ⟨u, -, terms, ht, -⟩ := hS q hq
    have hstep : stepCode h (encode q) p.1 p.2 = some (encode q') := by rw [stepCode_encode hh1, hq']; rfl
    have := (rowTerms_spec h find wt (encode q) (inputList h) terms ht).1 p ((mem_inputList hh1 p).mpr hp)
      (encode q') hstep
    obtain ⟨u', hu'⟩ := Option.isSome_iff_exists.mp this
    exact Finset.mem_image.mpr ⟨(encode q', u'), hfind _ _ hu', by simp only [decode_encode]⟩
  · intro q _; exact vOf_pos _ _
  · intro q hq
    obtain ⟨u, hu, terms, ht, hi⟩ := hS q hq
    rw [sum_inputs_eq hh1]
    simp only [hcontrib]
    rw [← (rowTerms_spec h find wt (encode q) (inputList h) terms ht).2, vOf_some hu]
    exact rowIneq_sound lam u terms hi

end CS31a
