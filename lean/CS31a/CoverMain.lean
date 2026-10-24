import CS31a.CoverStep
import CS31a.Fast

/-!
# The covering step: acceptance and the next invariant (paper Lemma 3.1, induction step)
-/

namespace CS31a

theorem T_len_pos1 (c : Bool) (l : ℤ) : 1 ≤ (T c l).1.length := by unfold T; split_ifs <;> simp
theorem T_len_pos2 (c : Bool) (l : ℤ) : 1 ≤ (T c l).2.length := by unfold T; split_ifs <;> simp

theorem T_last1 (c : Bool) (l : ℤ) : (T c l).1.getD ((T c l).1.length - 1) false = c := by
  unfold T; split_ifs <;> simp [List.getD_eq_getElem?_getD, List.getElem?_append_right]

theorem T_last2 (c : Bool) (l : ℤ) : (T c l).2.getD ((T c l).2.length - 1) false = c := by
  unfold T; split_ifs <;> simp [List.getD_eq_getElem?_getD, List.getElem?_append_right]

theorem trunc_nonneg_iff (h : ℕ) (hh : 2 ≤ h) (c : Bool) (lo : ℤ) : 0 ≤ (trunc h (c, lo)).2 ↔ 0 ≤ lo := by
  unfold trunc; simp only; split_ifs with hl <;> simp [min_def, max_def] <;> split_ifs <;> omega

/-- Between two points, a function with nonnegative steps is squeezed. -/
theorem squeeze_steps (f : ℕ → ℤ) (a b : ℕ) (hst : ∀ r, a < r → r ≤ b → 0 ≤ f r - f (r - 1)) :
    ∀ r, a ≤ r → r ≤ b → f a ≤ f r ∧ f r ≤ f b := by
  have up : ∀ r, a ≤ r → r ≤ b → f a ≤ f r := by
    intro r h1 h2
    induction r with
    | zero => rw [show a = 0 by omega]
    | succ r ih =>
      rcases Nat.eq_or_lt_of_le h1 with heq | hlt
      · rw [heq]
      · have := hst (r + 1) (by omega) h2; simp at this; have := ih (by omega) (by omega); omega
  have down : ∀ k r, r + k = b → a ≤ r → f r ≤ f b := by
    intro k
    induction k with
    | zero => intro r hr _; rw [show r = b by omega]
    | succ k ih =>
      intro r hr ha
      have h1 := ih (r + 1) (by omega) (by omega)
      have h2 := hst (r + 1) (by omega) (by omega); simp at h2
      omega
  exact fun r h1 h2 => ⟨up r h1 h2, down (b - r) r (by omega) h1⟩

theorem T_nonneg_snd (c : Bool) (l : ℤ) (hl : 0 ≤ l) : (T c l).2 = [c] := by unfold T; rw [if_pos hl]
theorem T_neg_fst (c : Bool) (l : ℤ) (hl : l < 0) : (T c l).1 = [c] := by unfold T; rw [if_neg (by omega)]

theorem seg_length (X : List Bool) (I I' : ℕ) (hI : I ≤ I') (hX : I' ≤ X.length) : (seg X I I').length = I' - I := by
  rw [seg_eq_map _ _ _ hI hX]; simp


section Main

variable {h : ℕ} {A B : List Bool}

/-- The induction step of the covering lemma: the truncated next pair is accepted and the invariant moves to the
next chain cell. -/
theorem cover_step (hh : 2 ≤ h) {q : State h} {I J I' J' : ℕ}
    (hinv : CovInv h A B q I J) (hseg : SegOK h A B (I, J) (I', J'))
    (hIh : h ≤ I) (hJh : h ≤ J) (hI' : I' ≤ (padL h A).length) (hJ' : J' ≤ (padL h B).length) :
    ∃ q', step q (symAt (padL h A) I')
        (trunc h (symAt (padL h A) I', ((I' - I : ℕ) : ℤ) - ((J' - J : ℕ) : ℤ))).2 = some q' ∧
      CovInv h A B q' I' J' := by
  obtain ⟨φ, ψ, hφm, hψm, hφh, hψh, hsx, hsy, hcolI, hrowI⟩ := hinv
  have hlt1 := hseg.lt1
  have hlt2 := hseg.lt2
  simp only at hlt1 hlt2
  set c := symAt (padL h A) I' with hc
  set lo : ℤ := ((I' - I : ℕ) : ℤ) - ((J' - J : ℕ) : ℤ) with hlo
  obtain ⟨hsegA, hsegB⟩ := seg_T h A B hseg hI' hJ'
  simp only at hsegA hsegB
  obtain ⟨htop, htoplen⟩ := top_eq_seg c lo hh I I' hsegA hlt1.le hI'
  obtain ⟨hbot, hbotlen⟩ := bot_eq_seg c lo hh J J' hsegB hlt2.le hJ'
  have hsa0 := fun r h1 h2 => symA_ext q c lo hh I I' φ hsx hsegA hIh hlt1.le hI' r h1 h2
  have hsb0 := fun s h1 h2 => symB_ext q c lo hh J J' ψ hsy hsegB hJh hlt2.le hJ' s h1 h2
  set l := (trunc h (c, lo)).2 with hl
  have hA1 := T_len_pos1 c l
  have hB1 := T_len_pos2 c l
  set α := h + (T c l).1.length with hα
  set β := h + (T c l).2.length with hβ
  set φe : ℕ → ℕ := fun r => if r ≤ h then φ r else I' - α + r with hφe
  set ψe : ℕ → ℕ := fun s => if s ≤ h then ψ s else J' - β + s with hψe
  have hφem : ∀ r, r < α → φe r < φe (r + 1) := by
    intro r hr
    simp only [hφe]
    by_cases h1 : r + 1 ≤ h
    · rw [if_pos (by omega), if_pos h1]; exact hφm r (by omega)
    · by_cases h2 : r = h
      · rw [if_pos (by omega), if_neg h1, h2, hφh]; omega
      · rw [if_neg (by omega), if_neg h1]; omega
  have hψem : ∀ s, s < β → ψe s < ψe (s + 1) := by
    intro s hs
    simp only [hψe]
    by_cases h1 : s + 1 ≤ h
    · rw [if_pos (by omega), if_pos h1]; exact hψm s (by omega)
    · by_cases h2 : s = h
      · rw [if_pos (by omega), if_neg h1, h2, hψh]; omega
      · rw [if_neg (by omega), if_neg h1]; omega
  have hφeα : φe α = I' := by simp only [hφe]; rw [if_neg (by omega)]; omega
  have hψeβ : ψe β = J' := by simp only [hψe]; rw [if_neg (by omega)]; omega
  have hφeh : φe h = I := by simp only [hφe]; rw [if_pos le_rfl, hφh]
  have hψeh : ψe h = J := by simp only [hψe]; rw [if_pos le_rfl, hψh]
  have hsa : ∀ r, 1 ≤ r → r ≤ α → symA q c l r = symAt (padL h A) (φe r) := hsa0
  have hsb : ∀ s, 1 ≤ s → s ≤ β → symB q c l s = symAt (padL h B) (ψe s) := hsb0
  set C : ℤ := (Lt h A B I J : ℤ) with hC
  have hcmp := cmp_claim (A := A) (B := B) q c l φe ψe α β C hφem hψem (by omega) (by omega) (by omega) hsa hsb
    (fun r hr => by
      have := hcolI r hr; simp only [hφe, hψe, if_pos hr, if_pos le_rfl, hψh]; exact this)
    (fun s hs => by
      have := hrowI s hs; simp only [hφe, hψe, if_pos hs, if_pos le_rfl, hφh]; exact this)
    (by rw [hφeα]; exact hI') (by rw [hψeβ]; exact hJ')
  -- the window table and its increments
  set W := win h (symA q c l) (symB q c l) (colH q) (rowH q) with hW
  have hinc := win_inc01 h (symA q c l) (symB q c l) (colH q) (rowH q) (by omega)
    (by rw [colH_h, rowH_h])
    (fun r h1 h2 => by
      have := colH_succ q (r - 1) (by omega); rw [Nat.sub_add_cancel h1] at this
      rw [this]; cases q.dx ⟨r - 1, by omega⟩ <;> simp [bit])
    (fun s h1 h2 => by
      have := rowH_succ q (s - 1) (by omega); rw [Nat.sub_add_cancel h1] at this
      rw [this]; cases q.dy ⟨s - 1, by omega⟩ <;> simp [bit])
  have hWhh : W h h = 0 := by rw [hW, win_col h _ _ _ _ le_rfl, colH_h]
  -- SegOK values
  have hval := hseg.val
  have hup := hseg.up
  have hleft := hseg.left
  simp only at hval hup hleft
  have hlenA : (T c lo).1.length = I' - I := by rw [← hsegA, seg_length _ _ _ hlt1.le hI']
  have hlenB : (T c lo).2.length = J' - J := by rw [← hsegB, seg_length _ _ _ hlt2.le hJ']
  have hcmp' := fun r s hr hs hrs => hcmp (r + s) r s le_rfl hr hs hrs
  have hincV : ∀ r s, 1 ≤ r → 1 ≤ s → (h < r ∨ h < s) → 0 ≤ W r s - W (r - 1) s ∧ W r s - W (r - 1) s ≤ 1 :=
    fun r s h1 h2 h3 => (hinc (r + s) r s le_rfl h1 h2 h3).1
  have hincH : ∀ r s, 1 ≤ r → 1 ≤ s → (h < r ∨ h < s) → 0 ≤ W r s - W r (s - 1) ∧ W r s - W r (s - 1) ≤ 1 :=
    fun r s h1 h2 h3 => (hinc (r + s) r s le_rfl h1 h2 h3).2
  -- acceptance and the value at the corner
  have hacc : accepts h W α β = true ∧ W α β = 1 := by
    by_cases hlo0 : 0 ≤ lo
    · have hl0 : 0 ≤ l := (trunc_nonneg_iff h hh c lo).mpr hlo0
      have hbotc : (T c l).2 = [c] := T_nonneg_snd c l hl0
      have hβ1 : β = h + 1 := by rw [hβ, hbotc]; rfl
      have hJJ : J' - J = 1 := by rw [← hlenB, T_nonneg_snd c lo hlo0]; rfl
      have hφα1 : φe (α - 1) = I' - 1 := by
        simp only [hφe]
        by_cases h1 : α - 1 ≤ h
        · rw [if_pos h1]
          have hα1 : α - 1 = h := by omega
          rw [hα1, hφh]
          -- l = 0 hence lo = 0 and the A-segment is [c]
          have hl00 : (T c l).1.length = 1 := by omega
          have : l = 0 := by
            unfold T at hl00; rw [if_pos hl0] at hl00; simp at hl00; omega
          have hlo00 : lo = 0 := by
            rw [hl] at this; unfold trunc at this; simp only [if_pos hlo0] at this
            rw [min_def] at this; split_ifs at this <;> omega
          have : I' - I = 1 := by rw [← hlenA, hlo00]; simp [T]
          omega
        · rw [if_neg h1]; omega
      have hψh1 : ψe (h + 1) = J' := by
        simp only [hψe]; rw [if_neg (by omega)]; omega
      -- column h vanishes on rows h..α
      have hWah : W α h ≤ 0 := by
        have := hcmp' α h le_rfl (by omega) (Or.inr le_rfl)
        rw [hφeα, hψeh, show J = J' - 1 by omega, hleft] at this; linarith
      have hcol0 : ∀ r, h ≤ r → r ≤ α → W r h = 0 := by
        intro r h1 h2
        have := squeeze_steps (fun r => W r h) h α
          (fun r h1 h2 => (hincV r h (by omega) (by omega) (Or.inl h1)).1) r h1 h2
        rw [hWhh] at this; omega
      have hW1 : W (α - 1) (h + 1) = 0 := by
        have h1 := hcmp' (α - 1) (h + 1) (by omega) (by omega) (Or.inr (by omega))
        rw [hφα1, hψh1, hup] at h1
        have h2 := (hincH (α - 1) (h + 1) (by omega) (by omega) (Or.inr (by omega))).1
        rw [Nat.add_sub_cancel, hcol0 (α - 1) (by omega) (by omega)] at h2
        linarith
      have hsymα : symA q c l α = symB q c l β := by
        rw [hβ1]
        unfold symA symB
        rw [dif_neg (by omega), dif_neg (by omega), show α - h - 1 = (T c l).1.length - 1 by omega, T_last1,
          show h + 1 - h - 1 = 0 by omega, hbotc]; rfl
      have hWab : W α β = 1 := by
        rw [hW, win_rec h _ _ _ _ (Or.inl (by omega)) (by omega) (by omega), if_pos hsymα, ← hW, hβ1,
          Nat.add_sub_cancel, hcol0 (α - 1) (by omega) (by omega)]; rfl
      refine ⟨?_, hWab⟩
      rw [accepts_diag h W α β (by omega) (by omega)
        (by rw [hWab, hβ1, hW1]; norm_num) (by rw [hWab, hβ1, Nat.add_sub_cancel, hcol0 α (by omega) le_rfl]; norm_num)]
      rw [hβ1, Nat.add_sub_cancel]
      exact accepts_up_col h (by omega) W (α - 1) (by omega)
        (fun r h1 h2 => by rw [hcol0 r (by omega) (by omega), hcol0 (r - 1) (by omega) (by omega)])
    · have hl0 : l < 0 := by
        have := (trunc_nonneg_iff h hh c lo).not.mpr hlo0; rw [← hl] at this; omega
      have htopc : (T c l).1 = [c] := T_neg_fst c l hl0
      have hα1 : α = h + 1 := by rw [hα, htopc]; rfl
      have hII : I' - I = 1 := by rw [← hlenA, T_neg_fst c lo (by omega)]; rfl
      have hβ2 : h + 2 ≤ β := by
        have : 2 ≤ (T c l).2.length := by unfold T; rw [if_neg (by omega)]; simp; omega
        omega
      have hφh1 : φe (h + 1) = I' := by simp only [hφe]; rw [if_neg (by omega)]; omega
      have hψβ1 : ψe (β - 1) = J' - 1 := by simp only [hψe]; rw [if_neg (by omega)]; omega
      -- row h vanishes on columns h..β
      have hWhb : W h β ≤ 0 := by
        have := hcmp' h β (by omega) le_rfl (Or.inl le_rfl)
        rw [hφeh, hψeβ, show I = I' - 1 by omega, hup] at this; linarith
      have hrow0 : ∀ s, h ≤ s → s ≤ β → W h s = 0 := by
        intro s h1 h2
        have := squeeze_steps (fun s => W h s) h β
          (fun s h1 h2 => (hincH h s (by omega) (by omega) (Or.inr h1)).1) s h1 h2
        rw [hWhh] at this; omega
      have hW1 : W (h + 1) (β - 1) = 0 := by
        have h1 := hcmp' (h + 1) (β - 1) (by omega) (by omega) (Or.inl (by omega))
        rw [hφh1, hψβ1, hleft] at h1
        have h2 := (hincV (h + 1) (β - 1) (by omega) (by omega) (Or.inl (by omega))).1
        rw [Nat.add_sub_cancel, hrow0 (β - 1) (by omega) (by omega)] at h2
        linarith
      have hsymβ : symA q c l α = symB q c l β := by
        rw [hα1]
        unfold symA symB
        rw [dif_neg (by omega), dif_neg (by omega), show β - h - 1 = (T c l).2.length - 1 by omega, T_last2,
          show h + 1 - h - 1 = 0 by omega, htopc]; rfl
      have hWab : W α β = 1 := by
        rw [hW, win_rec h _ _ _ _ (Or.inl (by omega)) (by omega) (by omega), if_pos hsymβ, ← hW, hα1,
          Nat.add_sub_cancel, hrow0 (β - 1) (by omega) (by omega)]; rfl
      refine ⟨?_, hWab⟩
      rw [accepts_diag h W α β (by omega) (by omega)
        (by rw [hWab, hα1, Nat.add_sub_cancel, hrow0 β (by omega) le_rfl]; norm_num)
        (by rw [hWab, hα1, hW1]; norm_num)]
      rw [hα1, Nat.add_sub_cancel]
      have hwalk := hseg.walk
      simp only at hwalk
      rw [show I' - 1 = I by omega] at hwalk
      have hrowUL := hwalk.row
      refine accepts_left_row h (by omega) W (β - 1) (by omega) (fun s h1 h2 => ⟨?_, ?_⟩)
      · -- "up" is refused along row h (paper (2.2))
        have hc1 := hcmp' (h - 1) s (by omega) (by omega) (Or.inr (by omega))
        have hψs : ψe s = J' - β + s := by simp only [hψe]; rw [if_neg (by omega)]
        have hφh1' : φe (h - 1) ≤ I - 1 := by
          simp only [hφe]; rw [if_pos (by omega)]
          have := hφm (h - 1) (by omega); rw [Nat.sub_add_cancel (by omega), hφh] at this; omega
        have ht1 : J < ψe s := by rw [hψs]; omega
        have ht2 : ψe s ≤ J' - 1 := by rw [hψs]; omega
        obtain ⟨hI1, hne⟩ := hrowUL (ψe s) ht1 ht2
        have hle := (Lt_up_le h A B (I - 1) (ψe s)).1
        rw [Nat.sub_add_cancel hI1] at hle
        have hm1 := Lt_mono h A B hφh1' (le_refl (ψe s))
        have hm2 := Lt_mono h A B (show I ≤ I' by omega) ht2
        have hm3 := Lt_mono h A B (le_refl I) ht1.le
        rw [hleft] at hm2
        have : (Lt h A B (I - 1) (ψe s) : ℤ) + 1 ≤ Lt h A B I (ψe s) := by
          have : Lt h A B (I - 1) (ψe s) < Lt h A B I (ψe s) := lt_of_le_of_ne hle hne
          exact_mod_cast this
        rw [hrow0 s (by omega) (by omega)]
        intro heq
        push_cast at hm1 hm2 hm3
        omega
      · rw [hrow0 s (by omega) (by omega), hrow0 (s - 1) (by omega) (by omega)]
  -- the next state
  obtain ⟨hacc, hWab⟩ := hacc
  refine ⟨_, by unfold step; simp only []; rw [if_pos hacc], ?_⟩
  refine ⟨fun r => φe (α - h + r), fun s => ψe (β - h + s), fun r hr => hφem _ (by omega),
    fun s hs => hψem _ (by omega), by simp only; rw [show α - h + h = α by omega, hφeα],
    by simp only; rw [show β - h + h = β by omega, hψeβ], fun t => ?_, fun t => ?_, fun r hr => ?_, fun s hs => ?_⟩
  · simp only; rw [hsa _ (by omega) (by omega)]; congr 2 <;> omega
  · simp only; rw [hsb _ (by omega) (by omega)]; congr 2 <;> omega
  · simp only
    rw [colH_of_incr _ (fun t => W (α - h + t) β) (fun t => by simp only; congr 2 <;> omega)
      (fun t ht => by
        have := hincV (α - h + (t + 1)) β (by omega) (by omega) (Or.inr (by omega))
        rw [show α - h + (t + 1) - 1 = α - h + t by omega] at this
        rw [show α - h + (t + 1) = α - h + t + 1 by omega] at this; exact this) r hr]
    rw [show α - h + h = α by omega, hWab, hval]
    have := hcmp' (α - h + r) β (by omega) le_rfl (Or.inr (by omega))
    rw [hψeβ] at this
    push_cast; linarith
  · simp only
    rw [rowH_of_incr _ (fun t => W α (β - h + t)) (fun t => by simp only; congr 2 <;> omega)
      (fun t ht => by
        have := hincH α (β - h + (t + 1)) (by omega) (by omega) (Or.inl (by omega))
        rw [show β - h + (t + 1) - 1 = β - h + t by omega] at this
        rw [show β - h + (t + 1) = β - h + t + 1 by omega] at this; exact this) s hs]
    rw [show β - h + h = β by omega, hWab, hval]
    have := hcmp' α (β - h + s) le_rfl (by omega) (Or.inl (by omega))
    rw [hφeα] at this
    push_cast; linarith

end Main

end CS31a
