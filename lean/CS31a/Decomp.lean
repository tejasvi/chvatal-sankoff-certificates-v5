import CS31a.Canon

/-!
# From the chain of diagonal cells to minimal match pairs (paper Lemmas 2.2 and 2.3)
-/

namespace CS31a

variable (h : ℕ) (A B : List Bool)

theorem chainOK_val (p : ℕ × ℕ) : ∀ cs : List (ℕ × ℕ), ChainOK h A B p cs →
    Lt h A B (cs.getLastD p).1 (cs.getLastD p).2 = Lt h A B p.1 p.2 + cs.length := by
  intro cs
  induction cs generalizing p with
  | nil => intro _; simp
  | cons c cs ih =>
    intro ⟨hs, hc⟩
    rw [List.getLastD_cons, ih c hc, hs.val, List.length_cons]; ring

/-- No other matches inside a segment (the minimal match pair property). -/
theorem seg_nomatch {p p' : ℕ × ℕ} (hs : SegOK h A B p p') (hpA : p'.1 ≤ (padL h A).length)
    (hpB : p'.2 ≤ (padL h B).length) :
    ∀ r s, p.1 < r → r ≤ p'.1 → p.2 < s → s ≤ p'.2 → (r, s) ≠ p' →
      symAt (padL h A) r ≠ symAt (padL h B) s := by
  intro r s hr1 hr2 hs1 hs2 hne heq
  have hrec := Lt_rec h A B r s (by omega) (by omega) (by omega) (by omega)
  rw [if_pos heq] at hrec
  have hm := Lt_mono h A B (show p.1 ≤ r - 1 by omega) (show p.2 ≤ s - 1 by omega)
  by_cases hr : r < p'.1
  · have := Lt_mono h A B (show r ≤ p'.1 - 1 by omega) hs2
    rw [hs.up] at this; omega
  · have hrr : r = p'.1 := by omega
    have hss : s < p'.2 := by
      by_contra hc; exact hne (Prod.ext hrr (by omega))
    have := Lt_mono h A B (show r ≤ p'.1 by omega) (show s ≤ p'.2 - 1 by omega)
    rw [hs.left] at this; omega

/-- The segment `X[I+1..I']` of a list, as a list. -/
def seg (X : List Bool) (I I' : ℕ) : List Bool := (X.take I').drop I

theorem seg_eq_map (X : List Bool) (I I' : ℕ) (hI : I ≤ I') (hX : I' ≤ X.length) :
    seg X I I' = (List.range (I' - I)).map fun i => symAt X (I + 1 + i) := by
  apply List.ext_getElem (by simp only [seg, List.length_drop, List.length_take, List.length_map, List.length_range]; omega)
  intro i h1 h2
  simp only [List.length_map, List.length_range] at h2
  simp only [seg, List.getElem_drop, List.getElem_take, List.getElem_map, List.getElem_range, symAt]
  rw [show I + 1 + i - 1 = I + i by omega, List.getD_eq_getElem _ _ (by omega)]

theorem rep_snoc_ext {n : ℕ} {f : ℕ → Bool} {x y : Bool} (h1 : ∀ i < n, f i = x) (h2 : f n = y) :
    (List.range (n + 1)).map f = List.replicate n x ++ [y] := by
  rw [List.range_succ, List.map_append, List.map_singleton, h2]
  congr 1
  rw [show List.replicate n x = (List.range n).map (fun _ => x) by simp]
  apply List.map_congr_left
  intro i hi; exact h1 i (List.mem_range.mp hi)

theorem T_nonneg (c : Bool) (n : ℕ) : T c (n : ℤ) = (List.replicate n (!c) ++ [c], [c]) := by
  unfold T; rw [if_pos (by omega)]; simp

theorem T_neg (c : Bool) (m : ℕ) (hm : 1 ≤ m) : T c (-(m : ℤ)) = ([c], List.replicate m (!c) ++ [c]) := by
  unfold T; rw [if_neg (by omega)]; simp

theorem getElem_rep_snoc (n : ℕ) (x y : Bool) (i : ℕ) (hi : i < (List.replicate n x ++ [y]).length) :
    (List.replicate n x ++ [y])[i] = if i < n then x else y := by
  split_ifs with h
  · rw [List.getElem_append_left (by simpa using h), List.getElem_replicate]
  · rw [List.getElem_append_right (by simpa using h)]; simp

/-- The pair of a segment: `T_{c,l}` with `c` the last symbol and `l = ΔI - ΔJ` (paper Lemma 2.2). -/
theorem seg_T {p p' : ℕ × ℕ} (hs : SegOK h A B p p') (hpA : p'.1 ≤ (padL h A).length)
    (hpB : p'.2 ≤ (padL h B).length) :
    seg (padL h A) p.1 p'.1 = (T (symAt (padL h A) p'.1) ((p'.1 - p.1 : ℕ) - (p'.2 - p.2 : ℕ) : ℤ)).1 ∧
    seg (padL h B) p.2 p'.2 = (T (symAt (padL h A) p'.1) ((p'.1 - p.1 : ℕ) - (p'.2 - p.2 : ℕ) : ℤ)).2 := by
  have hnm := seg_nomatch h A B hs hpA hpB
  have hlt1 := hs.lt1
  have hlt2 := hs.lt2
  have hsym := hs.sym
  rw [seg_eq_map _ _ _ hlt1.le hpA, seg_eq_map _ _ _ hlt2.le hpB]
  have ne_of : ∀ r s, (r, s) ≠ p' ↔ ¬ (r = p'.1 ∧ s = p'.2) := by
    intro r s; rw [Ne, Prod.ext_iff]
  by_cases hb : p'.2 - p.2 = 1
  · rw [show ((p'.1 - p.1 : ℕ) - (p'.2 - p.2 : ℕ) : ℤ) = ((p'.1 - p.1 - 1 : ℕ) : ℤ) by omega, T_nonneg]
    dsimp only
    constructor
    · rw [show p'.1 - p.1 = (p'.1 - p.1 - 1) + 1 by omega]
      apply rep_snoc_ext
      · intro i hi
        have := hnm (p.1 + 1 + i) p'.2 (by omega) (by omega) (by omega) le_rfl ((ne_of _ _).mpr (by omega))
        rw [← hsym] at this
        exact Bool.eq_not_iff.mpr this
      · congr 1; omega
    · rw [hb]
      simp only [List.range_one, List.map_singleton, List.cons.injEq, and_true]
      rw [hsym]; congr 1; omega
  · by_cases ha : p'.1 - p.1 = 1
    · rw [show ((p'.1 - p.1 : ℕ) - (p'.2 - p.2 : ℕ) : ℤ) = -((p'.2 - p.2 - 1 : ℕ) : ℤ) by omega,
        T_neg _ _ (by omega)]
      dsimp only
      constructor
      · rw [ha]
        simp only [List.range_one, List.map_singleton, List.cons.injEq, and_true]
        congr 1; omega
      · rw [show p'.2 - p.2 = (p'.2 - p.2 - 1) + 1 by omega]
        apply rep_snoc_ext
        · intro j hj
          have := hnm p'.1 (p.2 + 1 + j) (by omega) le_rfl (by omega) (by omega) ((ne_of _ _).mpr (by omega))
          exact Bool.eq_not_iff.mpr (fun h' => this h'.symm)
        · rw [show p.2 + 1 + (p'.2 - p.2 - 1) = p'.2 by omega]; exact hsym.symm
    · exfalso
      have e1 := hnm (p.1 + 1) p'.2 (by omega) (by omega) (by omega) le_rfl ((ne_of _ _).mpr (by omega))
      have e2 := hnm p'.1 (p.2 + 1) (by omega) le_rfl (by omega) (by omega) ((ne_of _ _).mpr (by omega))
      have e3 := hnm (p.1 + 1) (p.2 + 1) (by omega) (by omega) (by omega) (by omega) ((ne_of _ _).mpr (by omega))
      rw [← hsym] at e1
      cases h1 : symAt (padL h A) (p.1 + 1) <;> cases h2 : symAt (padL h B) (p.2 + 1) <;>
        cases h3 : symAt (padL h A) p'.1 <;> simp_all

end CS31a
