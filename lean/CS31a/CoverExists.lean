import CS31a.CoverMain
import CS31a.Count

/-!
# `CoverExists h` holds for `h ≥ 2` (paper Lemmas 2.3 and 3.1)
-/

namespace CS31a

/-- The minimal match pairs of a chain of diagonal cells starting after `p`. -/
def chainPairs (h : ℕ) (A : List Bool) : ℕ × ℕ → List (ℕ × ℕ) → List (Bool × ℤ)
  | _, [] => []
  | p, c :: cs => (symAt (padL h A) c.1, ((c.1 - p.1 : ℕ) : ℤ) - ((c.2 - p.2 : ℕ) : ℤ)) :: chainPairs h A c cs

theorem runM_append {h : ℕ} (q : State h) (xs ys : List (Bool × ℤ)) :
    runM q (xs ++ ys) = (runM q xs).bind fun q' => runM q' ys := by
  induction xs generalizing q with
  | nil => simp [runM]
  | cons x xs ih =>
    simp only [List.cons_append, runM]
    cases step q x.1 x.2 with
    | none => rfl
    | some q' => simp [ih]

theorem getLastD_mem_cons {α : Type*} : ∀ (ds : List α) (d c : α), (d :: ds).getLastD c ∈ d :: ds := by
  intro ds
  induction ds with
  | nil => intro d c; simp
  | cons e es ih => intro d c; rw [List.getLastD_cons]; exact List.mem_cons_of_mem _ (ih e d)

theorem strA_append (xs ys : List (Bool × ℤ)) : strA (xs ++ ys) = strA xs ++ strA ys := by simp [strA]
theorem strB_append (xs ys : List (Bool × ℤ)) : strB (xs ++ ys) = strB xs ++ strB ys := by simp [strB]

theorem seg_append (X : List Bool) {I I' I'' : ℕ} (h1 : I ≤ I') (h2 : I' ≤ I'') (hX : I'' ≤ X.length) :
    seg X I I' ++ seg X I' I'' = seg X I I'' := by
  rw [seg_eq_map _ _ _ h1 (by omega), seg_eq_map _ _ _ h2 hX, seg_eq_map _ _ _ (by omega) hX]
  rw [show I'' - I = (I' - I) + (I'' - I') by omega, List.range_add, List.map_append, List.map_map]
  congr 1
  apply List.map_congr_left; intro j _; simp only [Function.comp]; congr 1; omega

variable {h : ℕ} {A B : List Bool}

/-- The run of `M_h` along the chain, with the covering invariant. -/
theorem cover_chain (hh : 2 ≤ h) : ∀ (cs : List (ℕ × ℕ)) (p : ℕ × ℕ) (q : State h), ChainOK h A B p cs →
    (∀ c ∈ cs, c.1 ≤ (padL h A).length ∧ c.2 ≤ (padL h B).length) → h ≤ p.1 → h ≤ p.2 →
    CovInv h A B q p.1 p.2 → (runM q ((chainPairs h A p cs).map (trunc h))).isSome = true := by
  intro cs
  induction cs with
  | nil => intro p q _ _ _ _ _; simp [chainPairs, runM]
  | cons c cs ih =>
    intro p q hch hb hp1 hp2 hinv
    obtain ⟨hseg, hrest⟩ := hch
    have hl1 := hseg.lt1
    have hl2 := hseg.lt2
    obtain ⟨q', hstep, hinv'⟩ := cover_step (A := A) (B := B) hh (I := p.1) (J := p.2) (I' := c.1) (J' := c.2) hinv
      (by simpa using hseg) hp1 hp2 (hb c (by simp)).1 (hb c (by simp)).2
    simp only [chainPairs, List.map_cons, runM]
    have : trunc h (symAt (padL h A) c.1, ((c.1 - p.1 : ℕ) : ℤ) - ((c.2 - p.2 : ℕ) : ℤ)) =
        (symAt (padL h A) c.1, (trunc h (symAt (padL h A) c.1, ((c.1 - p.1 : ℕ) : ℤ) - ((c.2 - p.2 : ℕ) : ℤ))).2) := rfl
    rw [this]
    simp only [hstep, Option.bind_some]
    exact ih c q' hrest (fun d hd => hb d (by simp [hd])) (by omega) (by omega) hinv'

/-- The strings of the chain pairs are the segments of the padded strings. -/
theorem chain_strings : ∀ (cs : List (ℕ × ℕ)) (p : ℕ × ℕ), ChainOK h A B p cs →
    (∀ c ∈ cs, c.1 ≤ (padL h A).length ∧ c.2 ≤ (padL h B).length) →
    strA (chainPairs h A p cs) = seg (padL h A) p.1 (cs.getLastD p).1 ∧
      strB (chainPairs h A p cs) = seg (padL h B) p.2 (cs.getLastD p).2 := by
  intro cs
  induction cs with
  | nil => intro p _ _; simp [chainPairs, strA, strB, seg]
  | cons c cs ih =>
    intro p hch hb
    obtain ⟨hseg, hrest⟩ := hch
    obtain ⟨hA', hB'⟩ := seg_T h A B hseg (hb c (by simp)).1 (hb c (by simp)).2
    obtain ⟨ihA, ihB⟩ := ih c hrest (fun d hd => hb d (by simp [hd]))
    have hlast : (c :: cs).getLastD p = cs.getLastD c := List.getLastD_cons
    -- the last cell is at least `c` and within the strings
    have hmono : ∀ (ds : List (ℕ × ℕ)) (e : ℕ × ℕ), ChainOK h A B e ds →
        e.1 ≤ (ds.getLastD e).1 ∧ e.2 ≤ (ds.getLastD e).2 := by
      intro ds
      induction ds with
      | nil => intro e _; simp
      | cons d ds ihd =>
        intro e hd
        obtain ⟨hs, hr⟩ := hd
        have := ihd d hr
        rw [List.getLastD_cons]
        exact ⟨by have := hs.lt1; omega, by have := hs.lt2; omega⟩
    have hm := hmono cs c hrest
    have hlastb : (cs.getLastD c).1 ≤ (padL h A).length ∧ (cs.getLastD c).2 ≤ (padL h B).length := by
      cases cs with
      | nil => simpa using hb c (by simp)
      | cons d ds => exact hb _ (List.mem_cons_of_mem _ (getLastD_mem_cons ds d c))
    rw [hlast]
    simp only [chainPairs, strA_cons, strB_cons]
    rw [ihA, ihB, ← hA', ← hB']
    exact ⟨seg_append _ hseg.lt1.le hm.1 hlastb.1, seg_append _ hseg.lt2.le hm.2 hlastb.2⟩

theorem chainPairs_length (A : List Bool) : ∀ (cs : List (ℕ × ℕ)) (p : ℕ × ℕ),
    (chainPairs h A p cs).length = cs.length := by
  intro cs; induction cs with
  | nil => intro p; rfl
  | cons c cs ih => intro p; simp [chainPairs, ih]

theorem chain_last_ge : ∀ (cs : List (ℕ × ℕ)) (p : ℕ × ℕ), ChainOK h A B p cs →
    p.1 ≤ (cs.getLastD p).1 ∧ p.2 ≤ (cs.getLastD p).2 := by
  intro cs
  induction cs with
  | nil => intro p _; simp
  | cons d ds ih =>
    intro p hch
    obtain ⟨hs, hr⟩ := hch
    have := ih d hr
    rw [List.getLastD_cons]
    exact ⟨by have := hs.lt1; omega, by have := hs.lt2; omega⟩

theorem chain_le_last : ∀ (cs : List (ℕ × ℕ)) (p : ℕ × ℕ), ChainOK h A B p cs →
    ∀ c ∈ cs, c.1 ≤ (cs.getLastD p).1 ∧ c.2 ≤ (cs.getLastD p).2 := by
  intro cs
  induction cs with
  | nil => intro p _ c hc; simp at hc
  | cons d ds ih =>
    intro p hch c hc
    obtain ⟨hs, hr⟩ := hch
    rw [List.getLastD_cons]
    rcases List.mem_cons.mp hc with rfl | hc
    · exact chain_last_ge ds c hr
    · exact ih d hr c hc

theorem seg_padL_h (X : List Bool) (I : ℕ) (hI : h ≤ I) : seg (padL h X) h I = X.take (I - h) := by
  unfold seg padL
  rw [List.take_append, List.take_replicate, min_eq_right hI, List.drop_append_of_le_length (by simp)]
  simp

/-- **Paper Lemmas 2.3 and 3.1**: `CoverExists h` holds for every `h`. -/
theorem coverExists (h : ℕ) : CoverExists h := by
  intro hh A B _hlen k hk
  have hRA : (padL h A).length = h + A.length := by simp [padL]
  have hSB : (padL h B).length = h + B.length := by simp [padL]
  obtain ⟨rest, -, hch, hwalk, hgt⟩ := trace_chain h A B (by omega) _ (h + A.length) (h + B.length) le_rfl
    (by omega) (by omega) hRA.ge hSB.ge
  -- the number of pairs is the LCS
  have hv1 := chainOK_val h A B (h, h) rest hch
  have hv2 := hwalk.val_eq
  simp only at hv1 hv2
  rw [Lt_min h A B h h (by simp), min_self] at hv1
  rw [Lt_corner] at hv2
  have hlen : rest.length = lcsLen A B := by omega
  -- all cells lie within the strings
  have hle := hwalk.le
  simp only at hle
  have hb : ∀ c ∈ rest, c.1 ≤ (padL h A).length ∧ c.2 ≤ (padL h B).length := by
    intro c hc
    have := chain_le_last rest (h, h) hch c hc
    omega
  set ps := chainPairs h A (h, h) rest with hps
  have hpslen : ps.length = lcsLen A B := by rw [hps, chainPairs_length, hlen]
  have hrun := cover_chain (A := A) (B := B) hh rest (h, h) (q0 h) hch hb le_rfl le_rfl (covInv_q0 h A B)
  obtain ⟨hsA, hsB⟩ := chain_strings rest (h, h) hch hb
  have hlast1 : h ≤ (rest.getLastD (h, h)).1 := by
    rcases List.eq_nil_or_concat rest with hn | ⟨L', e, he⟩
    · simp [hn]
    · rw [he]; simp; exact (hgt e (by rw [he]; simp)).1.le
  have hlast2 : h ≤ (rest.getLastD (h, h)).2 := by
    rcases List.eq_nil_or_concat rest with hn | ⟨L', e, he⟩
    · simp [hn]
    · rw [he]; simp; exact (hgt e (by rw [he]; simp)).2.le
  rw [seg_padL_h A _ hlast1] at hsA
  rw [seg_padL_h B _ hlast2] at hsB
  refine ⟨ps.take k, by simp [hpslen]; omega, ?_, strA (ps.drop k) ++ A.drop ((rest.getLastD (h, h)).1 - h),
    strB (ps.drop k) ++ B.drop ((rest.getLastD (h, h)).2 - h), ?_, ?_⟩
  · have hsplit : ps.map (trunc h) = (ps.take k).map (trunc h) ++ (ps.drop k).map (trunc h) := by
      rw [← List.map_append, List.take_append_drop]
    rw [hsplit, runM_append] at hrun
    cases hr : runM (q0 h) ((ps.take k).map (trunc h)) with
    | none => rw [hr] at hrun; simp at hrun
    | some q' => rfl
  · rw [← List.append_assoc, ← strA_append, List.take_append_drop, hsA, List.take_append_drop]
  · rw [← List.append_assoc, ← strB_append, List.take_append_drop, hsB, List.take_append_drop]

/-- The interim hypotheses are now theorems. -/
theorem luekerCriterion (h : ℕ) : LuekerCriterion h := luekerCriterion_of_cover (coverExists h)

end CS31a
