import CS31a.KLaneTree
import CS31a.KLaneHom
import CS31a.KLaneSem

/-!
# A passing leaf gives `rowOK`

`mem_leafEntries`: the entries of a leaf are its lanes. `leafOKL_sound`: if the packed leaf test `leafOKL` passes,
every entry of the leaf is found from the root, and (if every entry of the tree is found from the root) every entry
passes `rowOK` with the lookup `t.findL`. The lane sums of `laneSumL` are the sums of `rowIneq` scaled by `2^e_min`.
-/

namespace CS31a

open CS31aCert

/-! ### Leaf entries are lanes -/

theorem C_two_pow_64 : (18446744073709551616 : ℕ) = 2 ^ 64 := by norm_num

theorem C_lane_zero (x : ℕ) : lane 0 x = x % 2 ^ 64 := by
  simp [lane]

theorem C_lane_succ (j x : ℕ) : lane (j + 1) x = lane j (x >>> 64) := by
  unfold lane
  rw [show 64 * (j + 1) = 64 + 64 * j by ring, Nat.shiftRight_add]

theorem mem_leafEntries {cnt keys vals : ℕ} {e : ℕ × ℕ} :
    e ∈ leafEntries cnt keys vals ↔ ∃ j < cnt, e = (lane j keys, lane j vals) := by
  induction cnt generalizing keys vals with
  | zero => simp [leafEntries]
  | succ cnt ih =>
    simp only [leafEntries, List.mem_cons, ih, C_two_pow_64]
    constructor
    · rintro (rfl | ⟨j, hj, rfl⟩)
      · exact ⟨0, by omega, by rw [C_lane_zero, C_lane_zero]⟩
      · exact ⟨j + 1, by omega, by rw [C_lane_succ, C_lane_succ]⟩
    · rintro ⟨j, hj, rfl⟩
      cases j with
      | zero => left; rw [C_lane_zero, C_lane_zero]
      | succ j => right; exact ⟨j, by omega, by rw [C_lane_succ, C_lane_succ]⟩

/-! ### The conjunction over the lanes -/

theorem C_andL (a b : Bool) : andL a b = (a && b) := by cases a <;> rfl

theorem C_natRec_andL (f : ℕ → Bool) : ∀ n,
    Nat.rec (motive := fun _ => Bool) true (fun j ih => andL ih (f j)) n = true ↔ ∀ j < n, f j = true
  | 0 => by
    show true = true ↔ _
    simp
  | n + 1 => by
    show andL (Nat.rec (motive := fun _ => Bool) true (fun j ih => andL ih (f j)) n) (f n) = true ↔ _
    rw [C_andL, Bool.and_eq_true, C_natRec_andL f n]
    constructor
    · rintro ⟨h1, h2⟩ j hj
      rcases Nat.lt_succ_iff_lt_or_eq.1 hj with hj | rfl
      · exact h1 j hj
      · exact h2
    · intro h
      exact ⟨fun j hj => h j (by omega), h n (by omega)⟩

/-- The row test of lane `j` in `leafOKL` (entry `(k, u)`, packed per-input results `res`). -/
noncomputable def C_rowT (h : ℕ) (t : KTree) (lam : ℕ) (res : List (ℕ × (ℕ × ℕ) × (KTree × ℕ))) (j k u : ℕ) :
    Bool :=
  andL (Nat.ble (Nat.succ k) (Nat.pow 2 (Nat.mul 4 h))) (andL
    (Option.rec (motive := fun _ => Bool) false (fun v => Nat.beq v u) (t.findL k)) (andL
    (Nat.ble (Nat.succ u) 9223372036854775808) (andL (Nat.ble 1 (dexpL u)) (andL (Nat.ble (dexpL u) 2046)
    (Option.rec (motive := fun _ => Bool) false
      (fun s => Nat.ble s (Nat.shiftLeft (Nat.mul lam (dmantL u)) (dexpL u))) (laneSumL h t j res))))))

theorem C_leafOKL_eq (h : ℕ) (t : KTree) (wt : List ℕ) (lam cnt keys vals : ℕ) :
    leafOKL h t wt lam cnt keys vals = Nat.rec (motive := fun _ => Bool) true
      (fun j ih => andL ih
        (C_rowT h t lam (mapL (inputResL h t wt cnt keys) (inputList h)) j (lane j keys) (lane j vals))) cnt :=
  rfl

theorem C_dexpL (u : ℕ) : dexpL u = dexp u := rfl

theorem C_dmantL (u : ℕ) : dmantL u = dmant u := rfl

theorem C_optRec_beq {o : Option ℕ} {u : ℕ}
    (h : Option.rec (motive := fun _ => Bool) false (fun v => Nat.beq v u) o = true) : o = some u := by
  cases o with
  | none => exact absurd h Bool.false_ne_true
  | some v =>
    have hv : Nat.beq v u = true := h
    rw [Nat.beq_eq] at hv
    rw [hv]

theorem C_optRec_ble {o : Option ℕ} {B : ℕ}
    (h : Option.rec (motive := fun _ => Bool) false (fun s => Nat.ble s B) o = true) : ∃ s, o = some s ∧ s ≤ B := by
  cases o with
  | none => exact absurd h Bool.false_ne_true
  | some s =>
    have hs : Nat.ble s B = true := h
    rw [Nat.ble_eq] at hs
    exact ⟨s, rfl, hs⟩

theorem C_rowT_spec {h : ℕ} {t : KTree} {lam : ℕ} {res : List (ℕ × (ℕ × ℕ) × (KTree × ℕ))} {j k u : ℕ}
    (hr : C_rowT h t lam res j k u = true) :
    k < 2 ^ (4 * h) ∧ t.findL k = some u ∧ u < 2 ^ 63 ∧ 1 ≤ dexp u ∧ dexp u ≤ 2046 ∧
      ∃ s, laneSumL h t j res = some s ∧ s ≤ (lam * dmant u) <<< dexp u := by
  unfold C_rowT at hr
  simp only [C_andL, Bool.and_eq_true] at hr
  obtain ⟨hk, hf, hu, hd1, hd2, hs⟩ := hr
  rw [Nat.ble_eq] at hk hu hd1 hd2
  refine ⟨hk, C_optRec_beq hf, ?_, hd1, hd2, C_optRec_ble hs⟩
  have : (9223372036854775808 : ℕ) = 2 ^ 63 := by norm_num
  rw [this] at hu
  exact hu

/-! ### Lane sums are row sums -/

theorem C_laneSumL_nil (h : ℕ) (t : KTree) (j : ℕ) : laneSumL h t j [] = some 0 := rfl

/-- Forcing to a literal does not change the value. -/
theorem C_forceL_eq {α : Type} (c : ℕ) (k : ℕ → α) : forceL c k = k c := by
  cases c <;> rfl

theorem C_laneSumL_cons (h : ℕ) (t : KTree) (j : ℕ) (x : ℕ × (ℕ × ℕ) × (KTree × ℕ))
    (xs : List (ℕ × (ℕ × ℕ) × (KTree × ℕ))) :
    laneSumL h t j (x :: xs) =
      Bool.rec (motive := fun _ => Option ℕ) (laneSumL h t j xs)
        (Option.rec (motive := fun _ => Option ℕ) none
          (fun u => Option.rec (motive := fun _ => Option ℕ) none
            (fun s => some (s + (x.1 * dmant u) <<< dexp u)) (laneSumL h t j xs))
          (Bool.rec (motive := fun _ => Option ℕ) (t.findL (lane j x.2.1.2)) (x.2.2.1.findL (lane j x.2.1.2))
            (Nat.beq (lane j x.2.1.2 >>> (2 * h)) x.2.2.2)))
        (Nat.beq (x.2.1.1 >>> (64 * j) % 2) 1) := by
  show Bool.rec (motive := fun _ => Option ℕ) (laneSumL h t j xs) (forceL _ _) _ = _
  rw [C_forceL_eq]
  rfl

theorem C_optBind_some {o r : Option ℕ} {g : ℕ → ℕ → ℕ} {s : ℕ}
    (h : Option.rec (motive := fun _ => Option ℕ) none
      (fun u => Option.rec (motive := fun _ => Option ℕ) none (fun s' => some (g u s')) r) o = some s) :
    ∃ u s', o = some u ∧ r = some s' ∧ s = g u s' := by
  cases o with
  | none => exact absurd h (by simp)
  | some u =>
    cases r with
    | none => exact absurd h (by simp)
    | some s' =>
      have hs : some (g u s') = some s := h
      exact ⟨u, s', rfl, rfl, (Option.some.inj hs).symm⟩

/-- A lookup in a finger (a subtree) or in the tree gives the lookup in the tree. -/
theorem C_lookup_sound {t F : KTree} (hT : ∀ e ∈ t.entries, t.findL e.1 = some e.2)
    (hF : ∀ e ∈ F.entries, e ∈ t.entries) {c u : ℕ} {b : Bool}
    (h : Bool.rec (motive := fun _ => Option ℕ) (t.findL c) (F.findL c) b = some u) : t.findL c = some u := by
  cases b with
  | false => exact h
  | true => exact hT (c, u) (hF (c, u) (KTree.findL_spec F c u h))

/-- The term sum of `laneSumL`. -/
def C_tsum (terms : List (ℕ × ℕ)) : ℕ := (terms.map fun p => (p.1 * dmant p.2) <<< dexp p.2).sum

theorem C_laneSum_sound {h : ℕ} {t : KTree} (hT : ∀ e ∈ t.entries, t.findL e.1 = some e.2) {wt : List ℕ}
    {k j : ℕ} (f : Bool × ℤ → ℕ × (ℕ × ℕ) × (KTree × ℕ)) (hf1 : ∀ c l, (f (c, l)).1 = wt.getD l.natAbs 0)
    (hf2 : ∀ p, ∀ e ∈ (f p).2.2.1.entries, e ∈ t.entries) :
    ∀ ps : List (Bool × ℤ),
      (∀ c l, (c, l) ∈ ps → stepCode h k c l =
        if (f (c, l)).2.1.1 >>> (64 * j) % 2 = 1 then some (lane j (f (c, l)).2.1.2) else none) →
      ∀ s, laneSumL h t j (ps.map f) = some s →
        ∃ terms, rowTerms h t.findL wt k ps = some terms ∧ s = C_tsum terms
  | [], _, s, hs => by
    rw [List.map_nil, C_laneSumL_nil] at hs
    exact ⟨[], rfl, by rw [← Option.some.inj hs]; rfl⟩
  | (c, l) :: ps, hstep, s, hs => by
    rw [List.map_cons, C_laneSumL_cons] at hs
    have hst := hstep c l List.mem_cons_self
    have hps : ∀ c' l', (c', l') ∈ ps → stepCode h k c' l' =
        if (f (c', l')).2.1.1 >>> (64 * j) % 2 = 1 then some (lane j (f (c', l')).2.1.2) else none :=
      fun c' l' hp => hstep c' l' (List.mem_cons_of_mem _ hp)
    by_cases hb : (f (c, l)).2.1.1 >>> (64 * j) % 2 = 1
    · rw [ite_eq_left_of_eq_true _ _ (eq_true hb)] at hst
      have hb' : Nat.beq ((f (c, l)).2.1.1 >>> (64 * j) % 2) 1 = true := by rw [Nat.beq_eq]; exact hb
      rw [hb'] at hs
      obtain ⟨u, s', hlook, hrest, rfl⟩ := C_optBind_some hs
      have hfind := C_lookup_sound hT (hf2 (c, l)) hlook
      obtain ⟨terms, hterms, rfl⟩ := C_laneSum_sound hT f hf1 hf2 ps hps s' hrest
      refine ⟨(wt.getD l.natAbs 0, u) :: terms, ?_, ?_⟩
      · simp only [rowTerms, hst, hfind, hterms]
      · simp only [C_tsum, List.map_cons, List.sum_cons, hf1]
        ring
    · rw [ite_eq_right_of_eq_false _ _ (eq_false hb)] at hst
      have hb' : Nat.beq ((f (c, l)).2.1.1 >>> (64 * j) % 2) 1 = false := by
        rw [Bool.eq_false_iff]; intro hc; rw [Nat.beq_eq] at hc; exact hb hc
      rw [hb'] at hs
      obtain ⟨terms, hterms, rfl⟩ := C_laneSum_sound hT f hf1 hf2 ps hps s hs
      refine ⟨terms, ?_, rfl⟩
      simp only [rowTerms, hst, hterms]

/-! ### The row inequality after scaling by `2^e_min` -/

theorem C_rowIneq_of {lam ui : ℕ} {terms : List (ℕ × ℕ)} (hle : C_tsum terms ≤ (lam * dmant ui) <<< dexp ui) :
    rowIneq lam ui terms = true := by
  unfold rowIneq
  dsimp only
  obtain ⟨hm0, hm⟩ := foldl_min_le (fun p : ℕ × ℕ => dexp p.2) terms (dexp ui)
  generalize terms.foldl (fun m p => min m (dexp p.2)) (dexp ui) = e at hm0 hm ⊢
  rw [foldl_add_eq, zero_add, Nat.ble_eq]
  have key : ∀ X d, e ≤ d → (X <<< (d - e)) * 2 ^ e = X <<< d := by
    intro X d hd
    rw [Nat.shiftLeft_eq, Nat.shiftLeft_eq, mul_assoc, ← Nat.pow_add, Nat.sub_add_cancel hd]
  have hsum : (terms.map fun p => (p.1 * dmant p.2) <<< (dexp p.2 - e)).sum * 2 ^ e = C_tsum terms := by
    rw [← List.sum_map_mul_right]
    unfold C_tsum
    congr 1
    apply List.map_congr_left
    intro p hp
    exact key _ _ (hm p hp)
  refine Nat.le_of_mul_le_mul_right ?_ (show 0 < 2 ^ e by positivity)
  rw [hsum, key _ _ hm0]
  exact hle

/-! ### The accepted inputs of a lane -/

/-- Lane `j` of the packed transition accepts exactly the inputs that `stepCode` accepts for `lane j keys`, with the
code `lane j` of the packed codes as successor. -/
theorem C_step_lane {h : ℕ} (hh1 : 1 ≤ h) (hh : h ≤ 16) {cnt keys j : ℕ} (hj : j < cnt) (c : Bool) (l : ℤ)
    (hl : l.natAbs < h) :
    stepCode h (lane j keys) c l =
      if (kstepLeafL h cnt keys c l).1 >>> (64 * j) % 2 = 1 then some (lane j (kstepLeafL h cnt keys c l).2)
      else none := by
  obtain ⟨h1, h2⟩ := lane_kstepLeafL keys hh1 hh hj c l hl
  obtain ⟨h3, h4⟩ := kstepLeafL_one (lane j keys) hh1 hh c l hl
  have hbit : (kstepLeafL h cnt keys c l).1 >>> (64 * j) % 2 = (kstepLeafL h 1 (lane j keys) c l).1 := by
    have e : (kstepLeafL h cnt keys c l).1 >>> (64 * j) % 2 = lane j (kstepLeafL h cnt keys c l).1 % 2 := by
      unfold lane; rw [Nat.mod_mod_of_dvd _ (by norm_num : 2 ∣ 2 ^ 64)]
    rw [e, h1]
    omega
  rw [← kstep_eq h _ hh1, h4, hbit, h2]

theorem C_inputList_natAbs {h : ℕ} {c : Bool} {l : ℤ} (hp : (c, l) ∈ inputList h) : l.natAbs < h := by
  simp only [inputList, List.mem_flatMap, List.mem_map, List.mem_range] at hp
  obtain ⟨c', -, i, hi, he⟩ := hp
  simp only [Prod.mk.injEq] at he
  obtain ⟨-, rfl⟩ := he
  omega

/-! ### Main theorem -/

theorem leafOKL_sound {h : ℕ} (hh1 : 1 ≤ h) (hh : h ≤ 16) {t : KTree} {wt : List ℕ} {lam cnt keys vals : ℕ}
    (hleaf : leafOKL h t wt lam cnt keys vals = true) :
    (∀ e ∈ leafEntries cnt keys vals, t.findL e.1 = some e.2) ∧
      ((∀ e ∈ t.entries, t.findL e.1 = some e.2) →
        ∀ e ∈ leafEntries cnt keys vals, rowOK h t.findL wt lam e.1 e.2 = true) := by
  rw [C_leafOKL_eq] at hleaf
  have hrows := (C_natRec_andL _ cnt).1 hleaf
  refine ⟨fun e he => ?_, fun hT e he => ?_⟩
  · obtain ⟨j, hj, rfl⟩ := mem_leafEntries.1 he
    exact (C_rowT_spec (hrows j hj)).2.1
  · obtain ⟨j, hj, rfl⟩ := mem_leafEntries.1 he
    obtain ⟨hk, hf, hu, hd1, hd2, s, hs, hsle⟩ := C_rowT_spec (hrows j hj)
    have hmap : mapL (inputResL h t wt cnt keys) (inputList h) = (inputList h).map (inputResL h t wt cnt keys) := by
      generalize inputList h = L
      induction L with
      | nil => rfl
      | cons x L ih => exact congrArg (List.cons _) ih
    rw [hmap] at hs
    obtain ⟨terms, hterms, rfl⟩ := C_laneSum_sound hT (inputResL h t wt cnt keys) (fun c l => rfl)
      (fun p e he => KTree.entries_fingerL_subset t _ _ e he) (inputList h)
      (fun c l hp => C_step_lane hh1 hh hj c l (C_inputList_natAbs hp)) s hs
    unfold rowOK
    simp only [hterms, hf, posNormal, Bool.and_eq_true, Nat.blt_eq, beq_self_eq_true, decide_eq_true_eq]
    exact ⟨⟨⟨hk, trivial⟩, ⟨hu, hd1⟩, hd2⟩, C_rowIneq_of hsle⟩

end CS31a
