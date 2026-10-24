import CS31aCert.KLane

/-!
# Combining packed-checker shards (core Lean only)

`checkKL_splitC` is `CS31a.checkKL_split` (CS31a/KLaneTree.lean) with a proof that needs no Mathlib, so that shard
modules can combine their own shards with only the core library and the checker oleans.
-/

namespace CS31a

open CS31aCert

theorem KS_andL_eq_true {a b : Bool} : andL a b = true ↔ a = true ∧ b = true := by
  cases a <;> cases b <;> simp [andL]

theorem KS_sub_append : ∀ (T : KTree) (p q : List Bool), T.sub (p ++ q) = (T.sub p).sub q
  | _, [], _ => rfl
  | .leaf c k v, _ :: _, q => by cases q <;> rfl
  | .node _ l r, b :: p, q => by cases b <;> exact KS_sub_append _ p q

/-- Combining shard checks by binary splits (a leaf is its own subtree). -/
theorem checkKL_splitC {h : Nat} {t : KTree} {wt : List Nat} {lam : Nat} (T : KTree) (p : List Bool)
    (h0 : checkKL h t wt lam (T.sub (p ++ [false])) = true) (h1 : checkKL h t wt lam (T.sub (p ++ [true])) = true) :
    checkKL h t wt lam (T.sub p) = true := by
  rw [KS_sub_append] at h0 h1
  generalize T.sub p = X at h0 h1 ⊢
  cases X with
  | leaf c k v => exact h0
  | node s l r =>
    have h0' : checkKL h t wt lam l = true := h0
    have h1' : checkKL h t wt lam r = true := h1
    show andL (checkKL h t wt lam l) (checkKL h t wt lam r) = true
    exact KS_andL_eq_true.mpr ⟨h0', h1'⟩

/-- `kl_split n` splits a goal `checkKL h t wt lam (T.sub p) = true` into the `2^n` subtrees below `p` (`checkKL_splitC`)
and closes each by `decide +kernel`, which checks it in its own auxiliary lemma (so kernel memory is per subtree). -/
syntax "kl_split " num : tactic

macro_rules
  | `(tactic| kl_split $n) =>
    if n.getNat == 0 then `(tactic| decide +kernel)
    else
      let k := Lean.Syntax.mkNumLit (toString (n.getNat - 1))
      `(tactic| (refine checkKL_splitC _ _ ?_ ?_ <;> kl_split $k))

end CS31a
