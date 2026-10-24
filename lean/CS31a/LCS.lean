import CS31a.Defs

/-!
# Basic facts about `lcsLen`
-/

namespace CS31a

theorem lcs_set_bdd (A B : List Bool) :
    BddAbove {k : ℕ | ∃ s : List Bool, List.Sublist s A ∧ List.Sublist s B ∧ s.length = k} :=
  ⟨A.length, fun _ ⟨_, hA, _, hk⟩ => hk ▸ hA.length_le⟩

theorem lcs_set_nonempty (A B : List Bool) :
    {k : ℕ | ∃ s : List Bool, List.Sublist s A ∧ List.Sublist s B ∧ s.length = k}.Nonempty :=
  ⟨0, [], List.nil_sublist _, List.nil_sublist _, rfl⟩

theorem le_lcsLen {A B s : List Bool} (hA : List.Sublist s A) (hB : List.Sublist s B) : s.length ≤ lcsLen A B :=
  le_csSup (lcs_set_bdd A B) ⟨s, hA, hB, rfl⟩

theorem lcsLen_spec (A B : List Bool) :
    ∃ s : List Bool, List.Sublist s A ∧ List.Sublist s B ∧ s.length = lcsLen A B :=
  Nat.sSup_mem (lcs_set_nonempty A B) (lcs_set_bdd A B)

theorem lcsLen_le_left (A B : List Bool) : lcsLen A B ≤ A.length := by
  obtain ⟨s, hA, -, hs⟩ := lcsLen_spec A B; rw [← hs]; exact hA.length_le

theorem lcsLen_le_right (A B : List Bool) : lcsLen A B ≤ B.length := by
  obtain ⟨s, -, hB, hs⟩ := lcsLen_spec A B; rw [← hs]; exact hB.length_le

/-- Concatenating common subsequences: `LCS(A₁A₂, B₁B₂) ≥ LCS(A₁, B₁) + LCS(A₂, B₂)`. -/
theorem lcsLen_add_le (A₁ A₂ B₁ B₂ : List Bool) :
    lcsLen A₁ B₁ + lcsLen A₂ B₂ ≤ lcsLen (A₁ ++ A₂) (B₁ ++ B₂) := by
  obtain ⟨s₁, h1A, h1B, h1⟩ := lcsLen_spec A₁ B₁
  obtain ⟨s₂, h2A, h2B, h2⟩ := lcsLen_spec A₂ B₂
  have := le_lcsLen (h1A.append h2A) (h1B.append h2B)
  rw [List.length_append, h1, h2] at this
  exact this

end CS31a
