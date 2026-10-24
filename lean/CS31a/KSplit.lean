import CS31a.KFastEq

/-!
# Combining kernel shards by binary splits

`checkK_split`: the check of the subtree at path `p` follows from the checks of the subtrees at `p ++ [false]` and
`p ++ [true]` (a leaf is its own subtree). A generator combines `2^d` shards with `2^d - 1` such steps instead of one case
split over `allPaths d` (whose elaboration grows much faster than linearly).
-/

namespace CS31a

open CS31aCert

theorem ktree_sub_append : ∀ (T : KTree) (p q : List Bool), T.sub (p ++ q) = (T.sub p).sub q
  | _, [], _ => rfl
  | .leaf c k v, _ :: _, q => by cases q <;> rfl
  | .node _ l r, b :: p, q => by cases b <;> exact ktree_sub_append _ p q

theorem checkK_split {h : ℕ} {t : KTree} {wt : List ℕ} {lam : ℕ} (T : KTree) (p : List Bool)
    (h0 : checkK h t wt lam (T.sub (p ++ [false])) = true) (h1 : checkK h t wt lam (T.sub (p ++ [true])) = true) :
    checkK h t wt lam (T.sub p) = true := by
  rw [ktree_sub_append] at h0 h1
  generalize T.sub p = X at h0 h1 ⊢
  cases X with
  | leaf c k v => exact h0
  | node s l r =>
    unfold checkK at h0 h1 ⊢
    simp only [KTree.sub, KTree.all, Bool.and_eq_true] at h0 h1 ⊢
    exact ⟨h0, h1⟩

theorem checkK_of_KF {h : ℕ} (hh : 1 ≤ h) {t : KTree} {wt : List ℕ} {lam : ℕ} {sub : KTree}
    (hs : checkKF h t wt lam sub = true) : checkK h t wt lam sub = true := by
  rw [← checkKK_eq hh, ← checkKF_eq]; exact hs

/-- The whole-tree check gives the hypotheses of `sound_of_rows` (as `checkK_sound` with paths of length 0). -/
theorem checkK_sound_all {h : ℕ} {T : KTree} {wt : List ℕ} {lam : ℕ} (hall : checkK h T wt lam T = true) :
    (∀ t u, T.find t = some u → (t, u) ∈ T.entries.toFinset) ∧
      (∀ e ∈ T.entries.toFinset, rowOK h T.find wt lam e.1 e.2 = true) :=
  checkK_sound 0 fun path hp => by rw [List.length_eq_zero_iff.mp hp]; exact hall

end CS31a
