import CS31a.KLaneTree
import CS31a.KLaneLeaf

/-!
# The whole packed check

`checkKL_sound_all`: if `checkKL` passes on the whole tree, every entry is found from the root (`leafOKL_sound`),
hence every entry passes `rowOK` with the lookup `T.findL` (`leafOKL_sound` again): the hypotheses of `sound_of_rows`.
-/

namespace CS31a

open CS31aCert

/-! ### The whole check -/

/-- The whole packed check gives the hypotheses of `sound_of_rows` with the lookup `T.findL`. -/
theorem checkKL_sound_all {h : ℕ} (hh1 : 1 ≤ h) (hh : h ≤ 16) {T : KTree} {wt : List ℕ} {lam : ℕ}
    (hall : checkKL h T wt lam T = true) :
    (∀ t u, T.findL t = some u → (t, u) ∈ T.entries.toFinset) ∧
      (∀ e ∈ T.entries.toFinset, rowOK h T.findL wt lam e.1 e.2 = true) := by
  have hleaves := allLeavesL_spec (fun cnt keys vals => leafOKL h T wt lam cnt keys vals) T hall
  have hfound : ∀ e ∈ T.entries, T.findL e.1 = some e.2 := by
    intro e he
    obtain ⟨cnt, keys, vals, hp, hmem⟩ := hleaves e he
    exact (leafOKL_sound hh1 hh hp).1 e hmem
  refine ⟨fun t u hf => List.mem_toFinset.mpr (T.findL_spec t u hf), fun e he => ?_⟩
  obtain ⟨cnt, keys, vals, hp, hmem⟩ := hleaves e (List.mem_toFinset.mp he)
  exact (leafOKL_sound hh1 hh hp).2 hfound e hmem

end CS31a

