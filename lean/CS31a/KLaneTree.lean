import CS31a.KLaneScalar
import CS31a.CheckK

/-!
# Soundness of the lane-packed kernel checker: lookups, fingers, leaves, shard splits

* `CS31aCert.KTree.findL_spec`: `findL` returns only entries (the bisection in a leaf only ever returns lane
  `mid < cnt`, whose key is the searched code; no order of the keys is used);
* `CS31aCert.KTree.entries_fingerL_subset`: a finger is a subtree;
* `CS31a.allLeavesL_spec`: `allLeavesL p` gives `p` on the leaf of every entry;
* `CS31a.checkKL_split`: shard checks combine by binary splits (a leaf is its own subtree);
(the whole-check theorem `checkKL_sound_all` is in CS31a/KLaneSound.lean, after CS31a/KLaneLeaf.lean).
-/

namespace CS31a

open CS31aCert

/-! ### Leaves: lanes are entries, the bisection returns lanes -/

theorem D_lane_succ (j x : ℕ) : lane (j + 1) x = lane j (x >>> 64) := by
  unfold lane; rw [← Nat.shiftRight_add, show 64 + 64 * j = 64 * (j + 1) by ring]

/-- Lane `j < cnt` of a leaf is one of its entries. -/
theorem D_lane_mem_leafEntries : ∀ (cnt keys vals j : ℕ), j < cnt →
    (lane j keys, lane j vals) ∈ leafEntries cnt keys vals
  | 0, _, _, _, hj => absurd hj (Nat.not_lt_zero _)
  | cnt + 1, keys, vals, 0, _ => by
    simp [leafEntries, lane]
  | cnt + 1, keys, vals, j + 1, hj => by
    rw [D_lane_succ, D_lane_succ, leafEntries]
    exact List.mem_cons_of_mem _ (D_lane_mem_leafEntries cnt (keys >>> 64) (vals >>> 64) j (by omega))

theorem D_leafFindL_zero (t keys vals lo hi : ℕ) : leafFindL t keys vals 0 lo hi = none := rfl

theorem D_leafFindL_succ (t keys vals n lo hi : ℕ) :
    leafFindL t keys vals (n + 1) lo hi =
      Bool.rec (motive := fun _ => Option ℕ)
        (Bool.rec (motive := fun _ => Option ℕ)
          (Bool.rec (motive := fun _ => Option ℕ) (leafFindL t keys vals n lo ((lo + hi) / 2))
            (leafFindL t keys vals n ((lo + hi) / 2 + 1) hi) (Nat.ble (lane ((lo + hi) / 2) keys + 1) t))
          (some (lane ((lo + hi) / 2) vals)) (Nat.beq (lane ((lo + hi) / 2) keys) t))
        none (Nat.ble hi lo) := rfl

/-- The bisection on `[lo, hi)` with `hi ≤ cnt` returns only the value of a lane `j < cnt` whose key is `t`. -/
theorem D_leafFindL_spec (t keys vals cnt : ℕ) : ∀ (fuel lo hi u : ℕ), hi ≤ cnt →
    leafFindL t keys vals fuel lo hi = some u → ∃ j < cnt, t = lane j keys ∧ u = lane j vals := by
  intro fuel
  induction fuel with
  | zero => intro lo hi u _ h; rw [D_leafFindL_zero] at h; exact absurd h (by simp)
  | succ n ih =>
    intro lo hi u hhi h
    rw [D_leafFindL_succ] at h
    cases hb : Nat.ble hi lo with
    | true => rw [hb] at h; exact absurd h (by simp)
    | false =>
      rw [hb] at h
      have hlt : lo < hi := by
        by_contra hc
        rw [Nat.ble_eq_true_of_le (by omega)] at hb
        exact absurd hb (by decide)
      cases hk : Nat.beq (lane ((lo + hi) / 2) keys) t with
      | true =>
        rw [hk] at h
        exact ⟨(lo + hi) / 2, by omega, (Nat.eq_of_beq_eq_true hk).symm, (Option.some.inj h).symm⟩
      | false =>
        rw [hk] at h
        cases hc : Nat.ble (lane ((lo + hi) / 2) keys + 1) t with
        | false => rw [hc] at h; exact ih lo ((lo + hi) / 2) u (by omega) h
        | true => rw [hc] at h; exact ih ((lo + hi) / 2 + 1) hi u hhi h

/-! ### Lookups -/

/-- `findL` returns only entries. -/
theorem _root_.CS31aCert.KTree.findL_spec (T : KTree) (t u : ℕ) (hf : T.findL t = some u) : (t, u) ∈ T.entries := by
  induction T with
  | leaf cnt keys vals =>
    obtain ⟨j, hj, rfl, rfl⟩ := D_leafFindL_spec t keys vals cnt 9 0 cnt u le_rfl hf
    exact D_lane_mem_leafEntries cnt keys vals j hj
  | node s l r ihl ihr =>
    have e : (KTree.node s l r).findL t =
        Bool.rec (motive := fun _ => Option ℕ) (r.findL t) (l.findL t) (Nat.ble (t + 1) s) := rfl
    rw [e] at hf
    simp only [KTree.entries, List.mem_append]
    cases hb : Nat.ble (t + 1) s with
    | false => rw [hb] at hf; exact Or.inr (ihr hf)
    | true => rw [hb] at hf; exact Or.inl (ihl hf)

/-! ### Fingers -/

/-- `KTree.fingerL` with a free accumulator. -/
noncomputable def D_fingerAux (lo hi : ℕ) (T : KTree) : KTree → KTree :=
  KTree.rec (motive := fun _ => KTree → KTree) (fun _ _ _ self => self)
    (fun s l r fl fr self => Bool.rec (motive := fun _ => KTree)
      (Bool.rec (motive := fun _ => KTree) self (fr r) (Nat.ble s lo)) (fl l) (Nat.ble hi s)) T

theorem D_fingerL_eq (T : KTree) (lo hi : ℕ) : T.fingerL lo hi = D_fingerAux lo hi T T := rfl

theorem D_fingerAux_subset (lo hi : ℕ) (T : KTree) :
    ∀ (S : KTree), ∀ e ∈ (D_fingerAux lo hi T S).entries, e ∈ S.entries ∨ e ∈ T.entries := by
  induction T with
  | leaf cnt keys vals => intro S e he; exact Or.inl he
  | node s l r ihl ihr =>
    intro S e he
    have eq : D_fingerAux lo hi (KTree.node s l r) S = Bool.rec (motive := fun _ => KTree)
        (Bool.rec (motive := fun _ => KTree) S (D_fingerAux lo hi r r) (Nat.ble s lo)) (D_fingerAux lo hi l l)
        (Nat.ble hi s) := rfl
    rw [eq] at he
    simp only [KTree.entries, List.mem_append]
    cases h1 : Nat.ble hi s with
    | true => rw [h1] at he; exact Or.inr (Or.inl ((ihl l e he).elim id id))
    | false =>
      rw [h1] at he
      cases h2 : Nat.ble s lo with
      | true => rw [h2] at he; exact Or.inr (Or.inr ((ihr r e he).elim id id))
      | false => rw [h2] at he; exact Or.inl he

/-- A finger is a subtree. -/
theorem _root_.CS31aCert.KTree.entries_fingerL_subset (T : KTree) (lo hi : ℕ) :
    ∀ e ∈ (T.fingerL lo hi).entries, e ∈ T.entries := by
  intro e he
  rw [D_fingerL_eq] at he
  exact (D_fingerAux_subset lo hi T T e he).elim id id

/-! ### All leaves -/

theorem D_andL_eq_true {a b : Bool} : andL a b = true ↔ a = true ∧ b = true := by
  cases a <;> cases b <;> simp [andL]

/-- `allLeavesL p` gives `p` on the leaf of every entry. -/
theorem allLeavesL_spec (p : ℕ → ℕ → ℕ → Bool) (T : KTree) (hT : T.allLeavesL p = true) :
    ∀ e ∈ T.entries, ∃ cnt keys vals, p cnt keys vals = true ∧ e ∈ leafEntries cnt keys vals := by
  induction T with
  | leaf cnt keys vals => intro e he; exact ⟨cnt, keys, vals, hT, he⟩
  | node s l r ihl ihr =>
    have hT' : andL (l.allLeavesL p) (r.allLeavesL p) = true := hT
    rw [D_andL_eq_true] at hT'
    intro e he
    simp only [KTree.entries, List.mem_append] at he
    rcases he with he | he
    · exact ihl hT'.1 e he
    · exact ihr hT'.2 e he

/-! ### Shards -/

theorem D_sub_append : ∀ (T : KTree) (p q : List Bool), T.sub (p ++ q) = (T.sub p).sub q
  | _, [], _ => rfl
  | .leaf c k v, _ :: _, q => by cases q <;> rfl
  | .node _ l r, b :: p, q => by cases b <;> exact D_sub_append _ p q

/-- Combining shard checks by binary splits (a leaf is its own subtree), as `checkK_split`. -/
theorem checkKL_split {h : ℕ} {t : KTree} {wt : List ℕ} {lam : ℕ} (T : KTree) (p : List Bool)
    (h0 : checkKL h t wt lam (T.sub (p ++ [false])) = true) (h1 : checkKL h t wt lam (T.sub (p ++ [true])) = true) :
    checkKL h t wt lam (T.sub p) = true := by
  rw [D_sub_append] at h0 h1
  generalize T.sub p = X at h0 h1 ⊢
  cases X with
  | leaf c k v => exact h0
  | node s l r =>
    have h0' : checkKL h t wt lam l = true := h0
    have h1' : checkKL h t wt lam r = true := h1
    show andL (checkKL h t wt lam l) (checkKL h t wt lam r) = true
    exact D_andL_eq_true.mpr ⟨h0', h1'⟩

end CS31a
