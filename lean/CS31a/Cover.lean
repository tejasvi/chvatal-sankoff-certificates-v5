import CS31a.CoverAux

/-!
# The covering lemma (paper Lemma 3.1)
-/

namespace CS31a

/-- The covering invariant `(I_k)` of the paper at the chain cell `(I, J)` (with `C = L*(I, J)`). -/
def CovInv (h : ℕ) (A B : List Bool) (q : State h) (I J : ℕ) : Prop :=
  ∃ φ ψ : ℕ → ℕ, (∀ r, r < h → φ r < φ (r + 1)) ∧ (∀ s, s < h → ψ s < ψ (s + 1)) ∧ φ h = I ∧ ψ h = J ∧
    (∀ t : Fin h, q.x t = symAt (padL h A) (φ (t.val + 1))) ∧
    (∀ t : Fin h, q.y t = symAt (padL h B) (ψ (t.val + 1))) ∧
    (∀ r, r ≤ h → colH q r + (Lt h A B I J : ℤ) ≤ Lt h A B (φ r) J) ∧
    (∀ s, s ≤ h → rowH q s + (Lt h A B I J : ℤ) ≤ Lt h A B I (ψ s))

/-- Strictly increasing on `[0, n]` gives `f r + (r' - r) ≤ f r'`. -/
theorem strict_mono_add {f : ℕ → ℕ} {n : ℕ} (hf : ∀ r, r < n → f r < f (r + 1)) :
    ∀ r r', r ≤ r' → r' ≤ n → f r + (r' - r) ≤ f r' := by
  intro r r' hrr hr'
  induction r' with
  | zero => rw [show r = 0 by omega]; simp
  | succ r' ih =>
    rcases Nat.eq_or_lt_of_le hrr with heq | hlt
    · rw [heq]; simp
    · have := ih (by omega) (by omega); have := hf r' (by omega); omega

theorem colH_q0 (h r : ℕ) (hr : r ≤ h) : colH (q0 h) r = (r : ℤ) - h := by
  rw [colH_eq_sum]
  have := sum_fin_telescope (fun t => (t : ℤ)) r h hr
  simp only [q0, bit, if_true]
  push_cast at this
  rw [show (∑ t : Fin h, if r < t.val + 1 then (1 : ℤ) else 0) =
    ∑ t : Fin h, if r < t.val + 1 then ((t.val + 1 : ℕ) : ℤ) - (t.val : ℤ) else 0 by
      apply Finset.sum_congr rfl; intro t _; split_ifs <;> push_cast <;> ring]
  push_cast; rw [this]; ring

theorem rowH_q0 (h s : ℕ) (hs : s ≤ h) : rowH (q0 h) s = (s : ℤ) - h := by
  have : rowH (q0 h) s = colH (q0 h) s := rfl
  rw [this, colH_q0 h s hs]

theorem symAt_padL_zero (h : ℕ) (X : List Bool) (t : ℕ) (ht1 : 1 ≤ t) (ht : t ≤ h) : symAt (padL h X) t = false := by
  unfold symAt padL
  rw [List.getD_append _ _ _ _ (by simp; omega), List.getD_eq_getElem _ _ (by simp; omega), List.getElem_replicate]

/-- The invariant at the start state, cell `(h, h)`. -/
theorem covInv_q0 (h : ℕ) (A B : List Bool) : CovInv h A B (q0 h) h h := by
  refine ⟨id, id, fun r _ => by simp, fun s _ => by simp, rfl, rfl, fun t => ?_, fun t => ?_, fun r hr => ?_,
    fun s hs => ?_⟩
  · simp only [q0, id]; rw [symAt_padL_zero h A _ (by omega) (by omega)]
  · simp only [q0, id]; rw [symAt_padL_zero h B _ (by omega) (by omega)]
  · rw [colH_q0 h r hr, Lt_min h A B h h (by simp), Lt_min h A B (id r) h (by simp [hr])]
    simp [min_eq_left hr]
  · rw [rowH_q0 h s hs, Lt_min h A B h h (by simp), Lt_min h A B h (id s) (by simp [hs])]
    simp [min_eq_right hs]

end CS31a
