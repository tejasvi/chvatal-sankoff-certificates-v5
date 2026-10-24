import CS31a.Code
import CS31a.Window

/-!
# The fast transition `stepCode` computes `δ_red` (paper, Section 3)

Main result: `stepCode_encode : stepCode h (encode q) c l = (stepRed q c l).map encode` for `h ≥ 1`.
-/

namespace CS31a

open CS31aCert

/-! ### The traceback on increments -/

theorem traceInc_eq_accepts (h : ℕ) (hh : 1 ≤ h) (W : ℕ → ℕ → ℤ) (vert horiz : ℕ → ℕ → Bool) (R S : ℕ)
    (hv : ∀ r s, h ≤ r → h ≤ s → r ≤ R → s ≤ S → ¬(r = h ∧ s = h) → vert r s = !decide (W (r - 1) s = W r s))
    (hz : ∀ r s, h ≤ r → h ≤ s → r ≤ R → s ≤ S → ¬(r = h ∧ s = h) → horiz r s = !decide (W r (s - 1) = W r s)) :
    ∀ fuel r s, r ≤ R → s ≤ S → r + s < fuel → traceInc h vert horiz fuel r s = accepts h W r s := by
  intro fuel
  induction fuel with
  | zero => intro r s _ _ h0; omega
  | succ fuel ih =>
    intro r s hr hs hf
    rw [accepts]
    simp only [traceInc]
    by_cases h1 : r < h ∨ s < h
    · simp [h1]
    · by_cases h2 : r = h ∧ s = h
      · simp [h2]
      · have hr0 : r ≠ 0 := by omega
        have hs0 : s ≠ 0 := by omega
        simp only [h1, h2, hr0, hs0, if_false, dite_false, hv r s (by omega) (by omega) hr hs h2,
          hz r s (by omega) (by omega) hr hs h2, Bool.not_not, decide_eq_true_eq]
        split_ifs
        · exact ih _ _ (by omega) hs (by omega)
        · exact ih _ _ hr (by omega) (by omega)
        · exact ih _ _ (by omega) (by omega) (by omega)

/-! ### Small facts about the state's table -/

theorem bit_inj_not {x y : ℤ} {v : Bool} (h : x - y = bit v) : v = !decide (y = x) := by
  cases v <;> simp [bit] at h ⊢ <;> omega

theorem decide_bit {x y : ℤ} {v : Bool} (h : x - y = bit v) : decide (x - y = 1) = v := by
  cases v <;> simp [bit] at h ⊢ <;> omega

theorem colH_succ {h : ℕ} (q : State h) (i : ℕ) (hi : i < h) :
    colH q (i + 1) - colH q i = bit (q.dx ⟨i, hi⟩) := by
  unfold colH
  rw [neg_sub_neg, ← Finset.sum_sub_distrib]
  rw [Finset.sum_eq_single ⟨i, hi⟩]
  · simp
  · intro t _ ht
    have : t.val ≠ i := fun e => ht (Fin.ext e)
    by_cases h1 : i + 1 < t.val + 1 <;> by_cases h2 : i < t.val + 1 <;> simp [h1, h2] <;> omega
  · simp

theorem rowH_succ {h : ℕ} (q : State h) (i : ℕ) (hi : i < h) :
    rowH q (i + 1) - rowH q i = bit (q.dy ⟨i, hi⟩) := by
  unfold rowH
  rw [neg_sub_neg, ← Finset.sum_sub_distrib]
  rw [Finset.sum_eq_single ⟨i, hi⟩]
  · simp
  · intro t _ ht
    have : t.val ≠ i := fun e => ht (Fin.ext e)
    by_cases h1 : i + 1 < t.val + 1 <;> by_cases h2 : i < t.val + 1 <;> simp [h1, h2] <;> omega
  · simp

theorem colH_h {h : ℕ} (q : State h) : colH q h = 0 := by
  unfold colH; simp only [neg_eq_zero]; apply Finset.sum_eq_zero; intro t _; simp

theorem rowH_h {h : ℕ} (q : State h) : rowH q h = 0 := by
  unfold rowH; simp only [neg_eq_zero]; apply Finset.sum_eq_zero; intro t _; simp

theorem topStr_eq (c : Bool) (l : ℤ) : topStr c l = (T c l).1 := by
  unfold topStr T; split_ifs <;> rfl

theorem botStr_eq (c : Bool) (l : ℤ) : botStr c l = (T c l).2 := by
  unfold botStr T; split_ifs <;> rfl

/-! ### The list form of the transition -/

theorem stepLists_spec {h : ℕ} (hh : 1 ≤ h) (q : State h) (c : Bool) (l : ℤ) :
    stepLists h (List.ofFn q.x) (List.ofFn q.y) (List.ofFn q.dx) (List.ofFn q.dy) c l =
      (step q c l).map (fun q' => (List.ofFn q'.x, List.ofFn q'.y, List.ofFn q'.dx, List.ofFn q'.dy)) := by
  unfold stepLists step
  simp only []
  rw [← topStr_eq, ← botStr_eq]
  set top := topStr c l with htop
  set bot := botStr c l with hbot
  set m := top.length with hm
  set k := bot.length with hk
  set a := symA q c l with ha
  set b := symB q c l with hb
  -- symbol lists
  have F1 : List.ofFn q.x = (List.range h).map (fun i => a (0 + 1 + i)) := by
    apply List.ext_getElem (by simp)
    intro i h1 h2
    simp only [List.getElem_ofFn, List.getElem_map, List.getElem_range, ha, symA]
    rw [dif_pos (by simp at h1; omega)]; congr 1; ext; simp
  have F3 : top = (List.range m).map (fun j => a (h + 1 + j)) := by
    apply List.ext_getElem (by simp only [List.length_map, List.length_range, hm])
    intro j h1 h2
    simp only [List.getElem_map, List.getElem_range, ha, symA]
    rw [dif_neg (by omega), ← topStr_eq, ← htop, show h + 1 + j - h - 1 = j by omega, List.getD_eq_getElem]
  have F2 : bot = (List.range k).map (fun j => b (h + 1 + j)) := by
    apply List.ext_getElem (by simp only [List.length_map, List.length_range, hk])
    intro j h1 h2
    simp only [List.getElem_map, List.getElem_range, hb, symB]
    rw [dif_neg (by omega), ← botStr_eq, ← hbot, show h + 1 + j - h - 1 = j by omega, List.getD_eq_getElem]
  have F4 : List.ofFn q.y ++ bot = (List.range (h + k)).map (fun i => b (0 + 1 + i)) := by
    apply List.ext_getElem (by simp [hk])
    intro i h1 h2
    simp only [List.getElem_map, List.getElem_range, hb, symB]
    by_cases hi : i < h
    · rw [List.getElem_append_left (by simpa using hi), List.getElem_ofFn, dif_pos (by omega)]
      congr 1; ext; simp
    · rw [List.getElem_append_right (by simp; omega), dif_neg (by omega), ← botStr_eq, ← hbot,
        List.getD_eq_getElem _ _ (by simp at h1 ⊢; omega)]
      congr 1; simp; omega
  have F13 : List.ofFn q.x ++ top = (List.range (h + m)).map (fun i => a (0 + 1 + i)) := by
    rw [F1, F3, List.range_add, List.map_append, List.map_map]
    congr 1; apply List.map_congr_left; intro j _; simp only [Function.comp]; congr 1; omega
  -- region R1
  have hcol : ∀ r, r ≤ h → win h a b (colH q) (rowH q) r h = colH q r := fun r hr => win_col h a b _ _ hr
  have hrowh : ∀ s, s ≤ h → win h a b (colH q) (rowH q) h s = rowH q s := by
    intro s hs
    rcases Nat.lt_or_eq_of_le hs with hs | hs
    · exact win_row h a b _ _ hs
    · rw [hs, hcol h le_rfl, colH_h, rowH_h]
  obtain ⟨R1a, R1b, R1c, R1d⟩ := region1_spec h a b (colH q) (rowH q) hh k h (List.ofFn q.dx) le_rfl (by simp)
    (fun i hi => by
      rw [hcol (1 + i) (by omega), hcol i (by omega), add_comm 1 i, colH_succ q i hi,
        List.getD_eq_getElem _ _ (by simpa using hi), List.getElem_ofFn])
    (hcol 0 (by omega))
  rw [← F1, ← F2] at R1a R1b R1c R1d
  set R1 := region1 (List.ofFn q.x) (List.ofFn q.dx) bot with hR1
  -- row h, extended by the bottom row of R1
  set H0 := List.ofFn q.dy ++ R1.2.map Prod.snd with hH0
  have hH0len : H0.length = h + k := by simp [hH0, R1c]
  have hH0 : ∀ i < h + k, win h a b (colH q) (rowH q) h (1 + i) - win h a b (colH q) (rowH q) h i =
      bit (H0.getD i false) := by
    intro i hi
    by_cases hih : i < h
    · rw [hrowh (1 + i) (by omega), hrowh i (by omega), add_comm 1 i, rowH_succ q i hih, hH0,
        List.getD_append _ _ _ _ (by simpa using hih), List.getD_eq_getElem _ _ (by simpa using hih),
        List.getElem_ofFn]
    · have hj : i - h < k := by omega
      have := (R1d (i - h) hj).2
      rw [show h + 1 + (i - h) = 1 + i by omega, show h + (i - h) = i by omega] at this
      rw [this, hH0, List.getD_append_right _ _ _ _ (by simp; omega), List.length_ofFn,
        show (false : Bool) = Prod.snd (false, false) from rfl, List.getD_map]
  -- region R2
  obtain ⟨R2a, R2b, R2c, R2d⟩ := region2_spec h a b (colH q) (rowH q) (h + k) m h H0 le_rfl hH0len hH0
    (win_row h a b _ _ (by omega))
  rw [← F4, ← F3] at R2a R2b R2c R2d
  set R2 := region2 (List.ofFn q.y ++ bot) H0 top with hR2
  -- the traceback
  rw [traceInc_eq_accepts h hh (win h a b (colH q) (rowH q)) _ _ (h + m) (h + k) ?hv ?hz (h + m + (h + k) + 1) (h + m) (h + k) le_rfl le_rfl
    (by omega)]
  case hv =>
    intro r s hr hs hrR hsS hne
    by_cases hrh : r ≤ h
    · have hrh' : r = h := le_antisymm hrh hr
      simp only [hrh, if_true]
      rw [hrh']
      have := (R1d (s - h - 1) (by omega)).1
      rw [show h + 1 + (s - h - 1) = s by omega] at this
      exact bit_inj_not this
    · simp only [hrh, if_false]
      have := ((R2d (r - h - 1) (by omega)).2.2.1) (s - 1) (by omega)
      rw [show h + 1 + (r - h - 1) = r by omega, show h + (r - h - 1) = r - 1 by omega,
        show 1 + (s - 1) = s by omega] at this
      exact bit_inj_not this
  case hz =>
    intro r s hr hs hrR hsS hne
    by_cases hrh : r ≤ h
    · have hrh' : r = h := le_antisymm hrh hr
      simp only [hrh, if_true]
      rw [hrh']
      have := (R1d (s - h - 1) (by omega)).2
      rw [show h + 1 + (s - h - 1) = s by omega, show h + (s - h - 1) = s - 1 by omega] at this
      exact bit_inj_not this
    · simp only [hrh, if_false]
      have := ((R2d (r - h - 1) (by omega)).2.2.2) (s - 1) (by omega)
      rw [show h + 1 + (r - h - 1) = r by omega, show 1 + (s - 1) = s by omega] at this
      exact bit_inj_not this
  -- the outputs
  split_ifs with hacc
  · simp only [Option.map_some, Option.some.injEq, Prod.mk.injEq]
    refine ⟨?_, ?_, ?_, ?_⟩
    · rw [F13]
      apply List.ext_getElem (by simp)
      intro t h1 h2
      simp only [List.getElem_drop, List.getElem_map, List.getElem_range, List.getElem_ofFn]
      congr 1; omega
    · rw [F4]
      apply List.ext_getElem (by simp)
      intro t h1 h2
      simp only [List.getElem_drop, List.getElem_map, List.getElem_range, List.getElem_ofFn]
      congr 1; omega
    · apply List.ext_getElem (by simp [R1a, R2c])
      intro t h1 h2
      simp only [List.getElem_drop, List.getElem_ofFn]
      by_cases ht : m + t < h
      · rw [List.getElem_append_left (by rw [R1a]; exact ht)]
        have := R1b (m + t) ht
        rw [List.getD_eq_getElem _ _ (by rw [R1a]; exact ht)] at this
        rw [show h + m - h + t + 1 = 1 + (m + t) by omega, show h + m - h + t = m + t by omega,
          decide_bit this]
      · rw [List.getElem_append_right (by rw [R1a]; omega), List.getElem_map]
        set j := m + t - R1.1.length with hj
        have hjm : j < m := by rw [hj, R1a]; simp at h1; omega
        have hjR : j < R2.2.length := by rw [R2c]; exact hjm
        obtain ⟨hl1, -, hv1, -⟩ := R2d j hjm
        have hx := hv1 (h + k - 1) (by omega)
        rw [List.getD_eq_getElem R2.2 ([], []) hjR] at hl1 hx
        rw [getLastD_eq_getD, hl1, List.getD_eq_getElem _ _ (by rw [hl1]; omega)]
        rw [List.getD_eq_getElem _ _ (by rw [hl1]; omega)] at hx
        rw [show h + 1 + j = h + m - h + t + 1 by omega, show h + j = h + m - h + t by omega,
          show 1 + (h + k - 1) = h + k by omega] at hx
        exact (decide_bit hx).symm
    · apply List.ext_getElem (by simp [R2a])
      intro t h1 h2
      simp only [List.getElem_drop, List.getElem_ofFn]
      have := R2b (k + t) (by simp [R2a] at h1; omega)
      rw [List.getD_eq_getElem _ _ (by rw [R2a]; simp [R2a] at h1; omega)] at this
      rw [show h + k - h + t + 1 = 1 + (k + t) by omega, show h + k - h + t = k + t by omega]
      exact (decide_bit this).symm
  · rfl

/-! ### The code form -/

theorem bitsMSB_encF {h : ℕ} (f : Fin h → Bool) : bitsMSB (encF f) h = List.ofFn f := by
  have := bitsMSB_ofBitsMSB (List.ofFn f); rwa [List.length_ofFn] at this

theorem stepCode_encode {h : ℕ} (hh : 1 ≤ h) (q : State h) (c : Bool) (l : ℤ) :
    stepCode h (encode q) c l = (stepRed q c l).map encode := by
  have hx := encF_lt q.x; have hy := encF_lt q.y; have hdx := encF_lt q.dx; have hdy := encF_lt q.dy
  unfold stepCode
  rw [encode, fieldX_packCode _ _ _ _ _ hx hy hdx hdy, fieldY_packCode _ _ _ _ _ hy hdx hdy,
    fieldDX_packCode _ _ _ _ _ hdx hdy, fieldDY_packCode _ _ _ _ _ hdy, bitsMSB_encF, bitsMSB_encF, bitsMSB_encF,
    bitsMSB_encF, stepLists_spec hh]
  unfold stepRed
  cases hs : step q c l with
  | none => rfl
  | some q' =>
    simp only [Option.map_some, Option.some.injEq]
    have h0 : 0 < h := by omega
    have hhead : (List.ofFn q'.x).headD false = q'.x ⟨0, h0⟩ := by
      cases h with
      | zero => omega
      | succ n => simp [List.ofFn_succ]
    rw [hhead]
    unfold rep encode encF
    rw [dif_pos h0]
    by_cases hx0 : q'.x ⟨0, h0⟩ = true
    · simp only [hx0, if_true, State.compl, List.map_ofFn]
      rfl
    · simp only [hx0, if_false, Bool.false_eq_true]

theorem ofFn_const_ofBitsMSB_false (n : ℕ) : ofBitsMSB (List.replicate n false) 0 = 0 := by
  induction n with
  | zero => rfl
  | succ n ih => rw [List.replicate_succ, ofBitsMSB_cons]; simpa using ih

theorem ofFn_const_ofBitsMSB_true (n : ℕ) : ofBitsMSB (List.replicate n true) 0 = 2 ^ n - 1 := by
  induction n with
  | zero => rfl
  | succ n ih =>
    rw [List.replicate_succ, ofBitsMSB_cons, if_pos rfl, List.length_replicate, ih, pow_succ]
    have : 1 ≤ 2 ^ n := Nat.one_le_two_pow
    omega

theorem encode_q0 (h : ℕ) : encode (q0 h) = startCode h := by
  unfold encode startCode q0 encF
  simp only [List.ofFn_const, ofFn_const_ofBitsMSB_false, ofFn_const_ofBitsMSB_true]

end CS31a
