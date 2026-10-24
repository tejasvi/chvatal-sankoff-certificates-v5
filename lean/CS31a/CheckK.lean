import CS31a.CheckSound
import CS31aCert.KTree

/-!
# Soundness of the kernel checker (`KTree` data)

`KTree.find t = some u` only for entries `(t, u)` of the tree, and `T.all p = true` gives `p` on every entry; the
shards (subtrees at all paths of a fixed length) cover the tree.
-/

namespace CS31a

open CS31aCert

/-- The entries of a leaf (logical description). -/
def leafEntries : ℕ → ℕ → ℕ → List (ℕ × ℕ)
  | 0, _, _ => []
  | cnt + 1, keys, vals =>
    (keys % 18446744073709551616, vals % 18446744073709551616) :: leafEntries cnt (keys >>> 64) (vals >>> 64)

/-- The entries of a tree. -/
def _root_.CS31aCert.KTree.entries : KTree → List (ℕ × ℕ)
  | .leaf cnt keys vals => leafEntries cnt keys vals
  | .node _ l r => l.entries ++ r.entries

theorem leafFind_spec (t : ℕ) : ∀ cnt keys vals u, leafFind t cnt keys vals = some u →
    (t, u) ∈ leafEntries cnt keys vals := by
  intro cnt
  induction cnt with
  | zero => intro keys vals u h; simp [leafFind] at h
  | succ cnt ih =>
    intro keys vals u h
    simp only [leafFind] at h
    split_ifs at h with hk
    · simp only [Option.some.injEq] at h
      simp only [Nat.beq_eq] at hk
      simp [leafEntries, ← hk, h]
    · exact List.mem_cons_of_mem _ (ih _ _ u h)

theorem _root_.CS31aCert.KTree.find_spec : ∀ (T : KTree) (t u : ℕ), T.find t = some u → (t, u) ∈ T.entries := by
  intro T
  induction T with
  | leaf cnt keys vals => intro t u h; exact leafFind_spec t cnt keys vals u h
  | node s l r ihl ihr =>
    intro t u h
    simp only [KTree.find] at h
    simp only [KTree.entries, List.mem_append]
    split_ifs at h
    · exact Or.inl (ihl t u h)
    · exact Or.inr (ihr t u h)

theorem leafAll_spec (p : ℕ → ℕ → Bool) : ∀ cnt keys vals, leafAll p cnt keys vals = true →
    ∀ e ∈ leafEntries cnt keys vals, p e.1 e.2 = true := by
  intro cnt
  induction cnt with
  | zero => intro _ _ _ e he; simp [leafEntries] at he
  | succ cnt ih =>
    intro keys vals h e he
    simp only [leafAll, Bool.and_eq_true] at h
    simp only [leafEntries, List.mem_cons] at he
    rcases he with rfl | he
    · exact h.1
    · exact ih _ _ h.2 e he

theorem _root_.CS31aCert.KTree.all_spec (p : ℕ → ℕ → Bool) : ∀ T : KTree, T.all p = true → ∀ e ∈ T.entries, p e.1 e.2 = true := by
  intro T
  induction T with
  | leaf cnt keys vals => exact leafAll_spec p cnt keys vals
  | node s l r ihl ihr =>
    intro h e he
    simp only [KTree.all, Bool.and_eq_true] at h
    simp only [KTree.entries, List.mem_append] at he
    rcases he with he | he
    · exact ihl h.1 e he
    · exact ihr h.2 e he

/-- The subtrees at all paths of length `d` cover the tree. -/
theorem _root_.CS31aCert.KTree.all_of_sub (p : ℕ → ℕ → Bool) : ∀ (d : ℕ) (T : KTree),
    (∀ path : List Bool, path.length = d → (T.sub path).all p = true) → T.all p = true := by
  intro d
  induction d with
  | zero => intro T h; exact h [] rfl
  | succ d ih =>
    intro T h
    cases T with
    | leaf cnt keys vals => exact h (List.replicate (d + 1) false) (by simp)
    | node s l r =>
      simp only [KTree.all, Bool.and_eq_true]
      exact ⟨ih l (fun path hp => h (false :: path) (by simp [hp])),
        ih r (fun path hp => h (true :: path) (by simp [hp]))⟩

/-- The kernel check gives the hypotheses of `sound_of_rows` with `E` = the entries of the tree. -/
theorem checkK_sound {h : ℕ} {T : KTree} {wt : List ℕ} {lam : ℕ} (d : ℕ)
    (hsh : ∀ path : List Bool, path.length = d → checkK h T wt lam (T.sub path) = true) :
    (∀ t u, T.find t = some u → (t, u) ∈ T.entries.toFinset) ∧
      (∀ e ∈ T.entries.toFinset, rowOK h T.find wt lam e.1 e.2 = true) := by
  refine ⟨fun t u hf => List.mem_toFinset.mpr (KTree.find_spec T t u hf), fun e he => ?_⟩
  exact KTree.all_spec _ T (KTree.all_of_sub _ d T hsh) e (List.mem_toFinset.mp he)

/-- All paths of length `d` (left = `false` first). -/
def allPaths : ℕ → List (List Bool)
  | 0 => [[]]
  | d + 1 => (allPaths d).map (false :: ·) ++ (allPaths d).map (true :: ·)

theorem mem_allPaths : ∀ (d : ℕ) (path : List Bool), path.length = d → path ∈ allPaths d := by
  intro d
  induction d with
  | zero => intro path hp; rw [List.length_eq_zero_iff] at hp; simp [allPaths, hp]
  | succ d ih =>
    intro path hp
    cases path with
    | nil => simp at hp
    | cons b bs =>
      simp only [List.length_cons, Nat.add_right_cancel_iff] at hp
      simp only [allPaths, List.mem_append, List.mem_map]
      cases b
      · exact Or.inl ⟨bs, ih bs hp, rfl⟩
      · exact Or.inr ⟨bs, ih bs hp, rfl⟩

/-- The kernel check over the shards listed by `allPaths d`. -/
theorem checkK_sound' {h : ℕ} {T : KTree} {wt : List ℕ} {lam : ℕ} (d : ℕ)
    (hsh : ∀ path ∈ allPaths d, checkK h T wt lam (T.sub path) = true) :
    (∀ t u, T.find t = some u → (t, u) ∈ T.entries.toFinset) ∧
      (∀ e ∈ T.entries.toFinset, rowOK h T.find wt lam e.1 e.2 = true) :=
  checkK_sound d fun path hp => hsh path (mem_allPaths d path hp)

/-- Combining the checks of the subtrees at all paths of length `d` below `T`. -/
theorem checkK_of_shards {h : ℕ} {t : KTree} {wt : List ℕ} {lam : ℕ} (T : KTree) (d : ℕ)
    (hs : ∀ path ∈ allPaths d, checkK h t wt lam (T.sub path) = true) : checkK h t wt lam T = true := by
  unfold checkK at *
  exact KTree.all_of_sub _ d T (fun path hp => hs path (mem_allPaths d path hp))

end CS31a
