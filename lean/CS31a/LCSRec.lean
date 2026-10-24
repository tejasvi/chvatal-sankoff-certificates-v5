import CS31a.LCS

/-!
# The LCS recurrence (paper (2.1)) and the zero prefix (Lemma 2.4)
-/

namespace CS31a

theorem sublist_snoc_iff {s A : List Bool} {a : Bool} :
    List.Sublist s (A ++ [a]) ↔ List.Sublist s A ∨ ∃ s', s = s' ++ [a] ∧ List.Sublist s' A := by
  rw [List.sublist_append_iff]
  constructor
  · rintro ⟨l₁, l₂, rfl, h₁, h₂⟩
    rcases List.sublist_singleton.mp h₂ with rfl | rfl
    · left; simpa using h₁
    · right; exact ⟨l₁, rfl, h₁⟩
  · rintro (h | ⟨s', rfl, h⟩)
    · exact ⟨s, [], by simp, h, List.nil_sublist _⟩
    · exact ⟨s', [a], rfl, h, List.Sublist.refl _⟩

theorem lcsLen_nil_left (B : List Bool) : lcsLen [] B = 0 := by
  have := lcsLen_le_left [] B; simpa using this

theorem lcsLen_nil_right (A : List Bool) : lcsLen A [] = 0 := by
  have := lcsLen_le_right A []; simpa using this

theorem lcsLen_mono {A A' B B' : List Bool} (hA : List.Sublist A A') (hB : List.Sublist B B') :
    lcsLen A B ≤ lcsLen A' B' := by
  obtain ⟨s, h1, h2, hs⟩ := lcsLen_spec A B
  rw [← hs]; exact le_lcsLen (h1.trans hA) (h2.trans hB)

theorem lcsLen_snoc_left_le (A B : List Bool) (a : Bool) : lcsLen (A ++ [a]) B ≤ lcsLen A B + 1 := by
  obtain ⟨s, h1, h2, hs⟩ := lcsLen_spec (A ++ [a]) B
  rw [← hs]
  rcases sublist_snoc_iff.mp h1 with h | ⟨s', rfl, h⟩
  · exact (le_lcsLen h h2).trans (Nat.le_succ _)
  · have : List.Sublist s' B := (List.sublist_append_left s' [a]).trans h2
    simpa using le_lcsLen h this

theorem lcsLen_snoc_right_le (A B : List Bool) (b : Bool) : lcsLen A (B ++ [b]) ≤ lcsLen A B + 1 := by
  obtain ⟨s, h1, h2, hs⟩ := lcsLen_spec A (B ++ [b])
  rw [← hs]
  rcases sublist_snoc_iff.mp h2 with h | ⟨s', rfl, h⟩
  · exact (le_lcsLen h1 h).trans (Nat.le_succ _)
  · have : List.Sublist s' A := (List.sublist_append_left s' [b]).trans h1
    simpa using le_lcsLen this h

/-- The LCS recurrence on appending one symbol to each string (paper (2.1)). -/
theorem lcsLen_snoc (A B : List Bool) (a b : Bool) :
    lcsLen (A ++ [a]) (B ++ [b]) =
      if a = b then lcsLen A B + 1 else max (lcsLen A (B ++ [b])) (lcsLen (A ++ [a]) B) := by
  have hA : List.Sublist A (A ++ [a]) := List.sublist_append_left A [a]
  have hB : List.Sublist B (B ++ [b]) := List.sublist_append_left B [b]
  apply le_antisymm
  · obtain ⟨s, h1, h2, hs⟩ := lcsLen_spec (A ++ [a]) (B ++ [b])
    rw [← hs]
    rcases sublist_snoc_iff.mp h1 with h1' | ⟨s₁, rfl, h1'⟩
    · have := le_lcsLen h1' h2
      split_ifs with hab
      · exact this.trans (lcsLen_snoc_right_le A B b)
      · exact this.trans (le_max_left _ _)
    · rcases sublist_snoc_iff.mp h2 with h2' | ⟨t₁, ht, h2'⟩
      · have := le_lcsLen h1 h2'
        split_ifs with hab
        · exact this.trans (lcsLen_snoc_left_le A B a)
        · exact this.trans (le_max_right _ _)
      · obtain ⟨rfl, hab⟩ := List.append_inj' ht rfl
        simp only [List.cons.injEq, and_true] at hab
        subst hab
        simp only [if_true]
        simpa using le_lcsLen h1' h2'
  · split_ifs with hab
    · subst hab
      obtain ⟨s, h1, h2, hs⟩ := lcsLen_spec A B
      have := le_lcsLen (h1.append (List.Sublist.refl [a])) (h2.append (List.Sublist.refl [a]))
      simpa [hs] using this
    · exact max_le (lcsLen_mono hA (List.Sublist.refl _)) (lcsLen_mono (List.Sublist.refl _) hB)

end CS31a
