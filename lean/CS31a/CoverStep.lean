import CS31a.Cover

/-!
# The inductive step of the covering lemma (paper Lemma 3.1)
-/

namespace CS31a

section Step

variable {h : ℕ} {A B : List Bool}

theorem seg_drop (X : List Bool) (I I' k : ℕ) : (seg X I I').drop k = seg X (I + k) I' := by
  unfold seg; rw [List.drop_drop]

/-- The truncated first string is the segment of the last `|top|` symbols before `I'`. -/
theorem top_eq_seg (c : Bool) (lo : ℤ) (hh : 2 ≤ h) (I I' : ℕ)
    (hseg : seg (padL h A) I I' = (T c lo).1) (hII : I ≤ I') (hI' : I' ≤ (padL h A).length) :
    (T c (trunc h (c, lo)).2).1 = seg (padL h A) (I' - (T c (trunc h (c, lo)).2).1.length) I' ∧
      (T c (trunc h (c, lo)).2).1.length ≤ I' - I := by
  obtain ⟨hsuf1, -, hlen1, -⟩ := T_trunc_suffix h hh c lo
  have hsl : (T c lo).1.length = I' - I := by rw [← hseg, seg_eq_map _ _ _ hII hI']; simp
  refine ⟨?_, by omega⟩
  calc (T c (trunc h (c, lo)).2).1
      = ((T c lo).1).drop ((T c lo).1.length - (T c (trunc h (c, lo)).2).1.length) := hsuf1
    _ = (seg (padL h A) I I').drop ((T c lo).1.length - (T c (trunc h (c, lo)).2).1.length) := by rw [hseg]
    _ = seg (padL h A) (I + ((T c lo).1.length - (T c (trunc h (c, lo)).2).1.length)) I' := seg_drop _ _ _ _
    _ = _ := by congr 1; omega

theorem bot_eq_seg (c : Bool) (lo : ℤ) (hh : 2 ≤ h) (J J' : ℕ)
    (hseg : seg (padL h B) J J' = (T c lo).2) (hJJ : J ≤ J') (hJ' : J' ≤ (padL h B).length) :
    (T c (trunc h (c, lo)).2).2 = seg (padL h B) (J' - (T c (trunc h (c, lo)).2).2.length) J' ∧
      (T c (trunc h (c, lo)).2).2.length ≤ J' - J := by
  obtain ⟨-, hsuf2, -, hlen2⟩ := T_trunc_suffix h hh c lo
  have hsl : (T c lo).2.length = J' - J := by rw [← hseg, seg_eq_map _ _ _ hJJ hJ']; simp
  refine ⟨?_, by omega⟩
  calc (T c (trunc h (c, lo)).2).2
      = ((T c lo).2).drop ((T c lo).2.length - (T c (trunc h (c, lo)).2).2.length) := hsuf2
    _ = (seg (padL h B) J J').drop ((T c lo).2.length - (T c (trunc h (c, lo)).2).2.length) := by rw [hseg]
    _ = seg (padL h B) (J + ((T c lo).2.length - (T c (trunc h (c, lo)).2).2.length)) J' := seg_drop _ _ _ _
    _ = _ := by congr 1; omega

/-- The window symbols agree with the padded strings along the extended maps (paper: "the extensions preserve
symbols"). -/
theorem symA_ext (q : State h) (c : Bool) (lo : ℤ) (hh : 2 ≤ h) (I I' : ℕ) (φ : ℕ → ℕ)
    (hsx : ∀ t : Fin h, q.x t = symAt (padL h A) (φ (t.val + 1)))
    (hseg : seg (padL h A) I I' = (T c lo).1) (hIh : h ≤ I) (hII : I ≤ I') (hI' : I' ≤ (padL h A).length)
    (r : ℕ) (hr1 : 1 ≤ r) (hr2 : r ≤ h + (T c (trunc h (c, lo)).2).1.length) :
    symA q c (trunc h (c, lo)).2 r =
      symAt (padL h A) (if r ≤ h then φ r else I' - (h + (T c (trunc h (c, lo)).2).1.length) + r) := by
  obtain ⟨htop, hlen⟩ := top_eq_seg c lo hh I I' hseg hII hI'
  unfold symA
  by_cases hrh : r ≤ h
  · rw [dif_pos ⟨hr1, hrh⟩, if_pos hrh, hsx ⟨r - 1, by omega⟩]
    congr 2; simp only; omega
  · rw [dif_neg (by omega), if_neg hrh]
    generalize hn1 : (T c (trunc h (c, lo)).2).1.length = n1 at htop hlen hr2 ⊢
    rw [htop, seg_eq_map _ _ _ (by omega) hI', List.getD_eq_getElem _ _ (by simp; omega)]
    simp only [List.getElem_map, List.getElem_range]
    congr 1; omega

theorem symB_ext (q : State h) (c : Bool) (lo : ℤ) (hh : 2 ≤ h) (J J' : ℕ) (ψ : ℕ → ℕ)
    (hsy : ∀ t : Fin h, q.y t = symAt (padL h B) (ψ (t.val + 1)))
    (hseg : seg (padL h B) J J' = (T c lo).2) (hJh : h ≤ J) (hJJ : J ≤ J') (hJ' : J' ≤ (padL h B).length)
    (s : ℕ) (hs1 : 1 ≤ s) (hs2 : s ≤ h + (T c (trunc h (c, lo)).2).2.length) :
    symB q c (trunc h (c, lo)).2 s =
      symAt (padL h B) (if s ≤ h then ψ s else J' - (h + (T c (trunc h (c, lo)).2).2.length) + s) := by
  obtain ⟨hbot, hlen⟩ := bot_eq_seg c lo hh J J' hseg hJJ hJ'
  unfold symB
  by_cases hsh : s ≤ h
  · rw [dif_pos ⟨hs1, hsh⟩, if_pos hsh, hsy ⟨s - 1, by omega⟩]
    congr 2; simp only; omega
  · rw [dif_neg (by omega), if_neg hsh]
    generalize hn2 : (T c (trunc h (c, lo)).2).2.length = n2 at hbot hlen hs2 ⊢
    rw [hbot, seg_eq_map _ _ _ (by omega) hJ', List.getD_eq_getElem _ _ (by simp; omega)]
    simp only [List.getElem_map, List.getElem_range]
    congr 1; omega

/-- The comparison claim of the covering proof: `W(r, s) + C ≤ L*(φe r, ψe s)` on the filled region. -/
theorem cmp_claim (q : State h) (c : Bool) (l : ℤ) (φe ψe : ℕ → ℕ) (α β : ℕ) (C : ℤ)
    (hφe : ∀ r, r < α → φe r < φe (r + 1)) (hψe : ∀ s, s < β → ψe s < ψe (s + 1))
    (hh1 : 1 ≤ h) (hhα : h ≤ α) (hhβ : h ≤ β)
    (hsa : ∀ r, 1 ≤ r → r ≤ α → symA q c l r = symAt (padL h A) (φe r))
    (hsb : ∀ s, 1 ≤ s → s ≤ β → symB q c l s = symAt (padL h B) (ψe s))
    (hcol : ∀ r, r ≤ h → colH q r + C ≤ Lt h A B (φe r) (ψe h))
    (hrow : ∀ s, s ≤ h → rowH q s + C ≤ Lt h A B (φe h) (ψe s))
    (hφA : φe α ≤ (padL h A).length) (hψB : ψe β ≤ (padL h B).length) :
    ∀ n r s, r + s ≤ n → r ≤ α → s ≤ β → (h ≤ r ∨ h ≤ s) →
      win h (symA q c l) (symB q c l) (colH q) (rowH q) r s + C ≤ Lt h A B (φe r) (ψe s) := by
  have hmφ := strict_mono_add hφe
  have hmψ := strict_mono_add hψe
  intro n
  induction n with
  | zero => intro r s hn hr hs hrs; omega
  | succ n ih =>
    intro r s hn hr hs hrs
    by_cases hb : r ≤ h ∧ s ≤ h
    · rw [win_eq, if_pos hb]
      by_cases hsh : s = h
      · rw [if_pos hsh]; subst hsh; exact hcol r hb.1
      · rw [if_neg hsh, if_pos (by omega)]
        have hrh : r = h := by omega
        subst hrh; exact hrow s hb.2
    · by_cases hr0 : r = 0
      · subst hr0
        rw [win_top h _ _ _ _ (by omega)]
        have := hcol 0 (by omega)
        have hm := Lt_mono h A B (le_refl (φe 0)) (show ψe h ≤ ψe s by have := hmψ h s (by omega) hs; omega)
        linarith
      · by_cases hs0 : s = 0
        · subst hs0
          rw [win_left h _ _ _ _ (by omega)]
          have := hrow 0 (by omega)
          have hm := Lt_mono h A B (show φe h ≤ φe r by have := hmφ h r (by omega) hr; omega) (le_refl (ψe 0))
          linarith
        · have hrs' : h < r ∨ h < s := by omega
          have hφr : 1 ≤ φe r := by have := hφe (r - 1) (by omega); rw [Nat.sub_add_cancel (by omega)] at this; omega
          have hψs : 1 ≤ ψe s := by have := hψe (s - 1) (by omega); rw [Nat.sub_add_cancel (by omega)] at this; omega
          have hφrA : φe r ≤ (padL h A).length := by have := hmφ r α hr le_rfl; omega
          have hψsB : ψe s ≤ (padL h B).length := by have := hmψ s β hs le_rfl; omega
          have hφ1 : φe (r - 1) ≤ φe r - 1 := by
            have := hφe (r - 1) (by omega); rw [Nat.sub_add_cancel (by omega)] at this; omega
          have hψ1 : ψe (s - 1) ≤ ψe s - 1 := by
            have := hψe (s - 1) (by omega); rw [Nat.sub_add_cancel (by omega)] at this; omega
          rw [win_rec h _ _ _ _ hrs' (by omega) (by omega)]
          split_ifs with hab
          · have hih := ih (r - 1) (s - 1) (by omega) (by omega) (by omega) (by omega)
            have hsym : symAt (padL h A) (φe r) = symAt (padL h B) (ψe s) := by
              rw [← hsa r (by omega) hr, ← hsb s (by omega) hs]; exact hab
            have hrec := Lt_rec h A B (φe r) (ψe s) hφr hφrA hψs hψsB
            rw [if_pos hsym] at hrec
            have hm := Lt_mono h A B hφ1 hψ1
            push_cast [hrec]
            linarith
          · have hih1 := ih (r - 1) s (by omega) (by omega) hs (by omega)
            have hih2 := ih r (s - 1) (by omega) hr (by omega) (by omega)
            have hm1 := Lt_mono h A B (show φe (r - 1) ≤ φe r by omega) (le_refl (ψe s))
            have hm2 := Lt_mono h A B (le_refl (φe r)) (show ψe (s - 1) ≤ ψe s by omega)
            rcases le_total (win h (symA q c l) (symB q c l) (colH q) (rowH q) (r - 1) s)
                (win h (symA q c l) (symB q c l) (colH q) (rowH q) r (s - 1)) with hle | hle
            · rw [max_eq_right hle]; push_cast at hm2 ⊢; linarith
            · rw [max_eq_left hle]; push_cast at hm1 ⊢; linarith

/-- `bit (decide (d = 1)) = d` for a 0/1 integer. -/
theorem bit_decide_eq {d : ℤ} (h0 : 0 ≤ d) (h1 : d ≤ 1) : bit (decide (d = 1)) = d := by
  rcases (show d = 0 ∨ d = 1 by omega) with rfl | rfl <;> simp [bit]

/-- The `colH` of a state whose `dx` are the increments of a column. -/
theorem colH_of_incr {h : ℕ} (q' : State h) (f : ℕ → ℤ)
    (hdx : ∀ t : Fin h, q'.dx t = decide (f (t.val + 1) - f t.val = 1))
    (h01 : ∀ t, t < h → 0 ≤ f (t + 1) - f t ∧ f (t + 1) - f t ≤ 1) (r : ℕ) (hr : r ≤ h) :
    colH q' r = f r - f h := by
  rw [colH_eq_sum]
  have : ∑ t : Fin h, (if r < t.val + 1 then bit (q'.dx t) else 0) =
      ∑ t : Fin h, (if r < t.val + 1 then f (t.val + 1) - f t.val else 0) := by
    apply Finset.sum_congr rfl; intro t _
    rw [hdx t, bit_decide_eq (h01 t t.2).1 (h01 t t.2).2]
  rw [this, sum_fin_telescope f r h hr]; ring

theorem rowH_of_incr {h : ℕ} (q' : State h) (f : ℕ → ℤ)
    (hdy : ∀ t : Fin h, q'.dy t = decide (f (t.val + 1) - f t.val = 1))
    (h01 : ∀ t, t < h → 0 ≤ f (t + 1) - f t ∧ f (t + 1) - f t ≤ 1) (s : ℕ) (hs : s ≤ h) :
    rowH q' s = f s - f h := by
  have := colH_of_incr (h := h) ⟨q'.y, q'.x, q'.dy, q'.dx⟩ f hdy h01 s hs
  simpa [colH, rowH] using this

end Step

end CS31a
