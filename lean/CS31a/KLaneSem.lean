import CS31a.KLaneScalar
import CS31a.KFastEq

/-!
# The packed transition of one lane is `kstep`

With one lane (`L = 1`) the masks of `kstepLeafL` are plain numbers (`laneRepL_one`).

* Fields: `revLanesL 1 h` of a masked field is `revBits h` of the field (`B_field_eq`).
* Region R1: `region1L = region1M` (`B_region1L_eq`). Region R2: `region2L` returns the rows `B_rows` (last row first),
  `region2M` packs them with `packRows`; both give the same `H` and column-`β` bits (`B_region2_eq`, `B_unpack`).
* Traceback: `traceInc` row by row (`B_trace_nostop`, `B_trace_stop`, `B_trace_rowh`); the packed row step leaves a row
  at its highest stop column (`B_row_stop`, `B_row_none`); the induction over the rows (`B_trace_rows`) and the row-`h`
  test (`B_final_alive`) give `B_trace_kstep`: the packed acceptance bit is `1` exactly when `traceInc` accepts.
* Codes: `B_code` (the complement via `spreadL_eq`, `packCode` as a disjunction of shifted fields).
-/

namespace CS31a

open CS31aCert

/-! ### Fields -/

theorem B_field_eq {h : ℕ} (hh : h ≤ 64) (z : ℕ) : revLanesL 1 h (z &&& (2 ^ h - 1)) = revBits h (z % 2 ^ h) 0 := by
  rw [revLanesL_one_eq hh, Nat.and_two_pow_sub_one_eq_mod]

/-! ### Region R1 -/

theorem B_region1L_eq {h : ℕ} (xs : ℕ) : ∀ (bs : List Bool) (V j av ah : ℕ), V < 2 ^ h →
    region1L (h - 1) (2 ^ h - 1) 1 xs bs V j av ah = region1M (h - 1) (2 ^ h - 1) xs V bs j av ah := by
  intro bs
  induction bs with
  | nil => intro V j av ah _; rfl
  | cons b bs ih =>
    intro V j av ah hV
    have hp : lineUpdL (2 ^ h - 1) (Bool.rec (motive := fun _ => ℕ) (Nat.xor xs (2 ^ h - 1)) xs b) V =
        lineUpdM (2 ^ h - 1) b xs V := by
      rw [lineUpdL_one hV, lineUpdM_sym]
    show region1L (h - 1) (2 ^ h - 1) 1 xs bs
        (lineUpdL (2 ^ h - 1) (Bool.rec (motive := fun _ => ℕ) (Nat.xor xs (2 ^ h - 1)) xs b) V).1 (Nat.succ j)
        (Nat.lor av (Nat.shiftLeft (Nat.land (Nat.shiftRight
          (lineUpdL (2 ^ h - 1) (Bool.rec (motive := fun _ => ℕ) (Nat.xor xs (2 ^ h - 1)) xs b) V).1 (h - 1)) 1) j))
        (Nat.lor ah (Nat.shiftLeft (Nat.land (Nat.shiftRight
          (lineUpdL (2 ^ h - 1) (Bool.rec (motive := fun _ => ℕ) (Nat.xor xs (2 ^ h - 1)) xs b) V).2 (h - 1)) 1) j)) =
      region1M (h - 1) (2 ^ h - 1) xs V (b :: bs) j av ah
    rw [hp, region1M, ih _ _ _ _ (lineUpdM_fst_lt hV b xs)]
    simp only [land_eq', lor_eq', shiftLeft_eq', shiftRight_eq', Nat.and_one_is_mod, Nat.succ_eq_add_one]

theorem B_region1M_lt {h : ℕ} (xs : ℕ) : ∀ (bs : List Bool) (V j av ah : ℕ), V < 2 ^ h → av < 2 ^ j → ah < 2 ^ j →
    (region1M (h - 1) (2 ^ h - 1) xs V bs j av ah).1 < 2 ^ h ∧
    (region1M (h - 1) (2 ^ h - 1) xs V bs j av ah).2.1 < 2 ^ (j + bs.length) ∧
    (region1M (h - 1) (2 ^ h - 1) xs V bs j av ah).2.2 < 2 ^ (j + bs.length)
  | [], V, j, av, ah, hV, hav, hah => by simp [region1M, hV, hav, hah]
  | b :: bs, V, j, av, ah, hV, hav, hah => by
    have hbit : ∀ x, ((x >>> (h - 1)) % 2) <<< j < 2 ^ (j + 1) := by
      intro x
      rw [Nat.shiftLeft_eq, pow_succ]
      have := Nat.mod_lt (x >>> (h - 1)) (by norm_num : 2 > 0)
      have : 0 < 2 ^ j := by positivity
      nlinarith
    have hj : 2 ^ j ≤ 2 ^ (j + 1) := Nat.pow_le_pow_right (by norm_num) (by omega)
    have h1 := Nat.or_lt_two_pow (lt_of_lt_of_le hav hj) (hbit (lineUpdM (2 ^ h - 1) b xs V).1)
    have h2 := Nat.or_lt_two_pow (lt_of_lt_of_le hah hj) (hbit (lineUpdM (2 ^ h - 1) b xs V).2)
    have := B_region1M_lt xs bs _ (j + 1) _ _ (lineUpdM_fst_lt hV b xs) h1 h2
    simp only [region1M, List.length_cons]
    rw [show j + (bs.length + 1) = j + 1 + bs.length by omega]
    exact this

/-! ### Region R2 -/

/-- The new rows of region R2 (first row first): (cross increments, new increments) of each line update. -/
def B_rows (full ys : ℕ) : List Bool → ℕ → List (ℕ × ℕ)
  | [], _ => []
  | a :: as, H => ((lineUpdM full a ys H).2, (lineUpdM full a ys H).1) :: B_rows full ys as (lineUpdM full a ys H).1

theorem B_rows_length (full ys : ℕ) : ∀ (as : List Bool) (H : ℕ), (B_rows full ys as H).length = as.length
  | [], _ => rfl
  | a :: as, H => by simp only [B_rows, List.length_cons, B_rows_length full ys as]

theorem B_rows_lt {β : ℕ} (ys : ℕ) : ∀ (as : List Bool) (H : ℕ), H < 2 ^ β →
    ∀ p ∈ B_rows (2 ^ β - 1) ys as H, p.1 < 2 ^ β ∧ p.2 < 2 ^ β
  | [], _, _ => by simp [B_rows]
  | a :: as, H, hH => by
    intro p hp
    simp only [B_rows, List.mem_cons] at hp
    rcases hp with rfl | hp
    · exact ⟨lineUpdM_snd_lt hH a ys, lineUpdM_fst_lt hH a ys⟩
    · exact B_rows_lt ys as _ (lineUpdM_fst_lt hH a ys) p hp

theorem B_region2L_cons (bm1 fullb one ys : ℕ) (a : Bool) (as : List Bool) (H j : ℕ) (rows : List (ℕ × ℕ))
    (ab : ℕ) : region2L bm1 fullb one ys (a :: as) H j rows ab =
      region2L bm1 fullb one ys as (lineUpdL fullb (Bool.rec (motive := fun _ => ℕ) (Nat.xor ys fullb) ys a) H).1
        (j + 1) (((lineUpdL fullb (Bool.rec (motive := fun _ => ℕ) (Nat.xor ys fullb) ys a) H).2,
          (lineUpdL fullb (Bool.rec (motive := fun _ => ℕ) (Nat.xor ys fullb) ys a) H).1) :: rows)
        (ab ||| ((((lineUpdL fullb (Bool.rec (motive := fun _ => ℕ) (Nat.xor ys fullb) ys a) H).2 >>> bm1) &&& one)
          <<< j)) := rfl

theorem B_region2_eq {β : ℕ} (ys : ℕ) : ∀ (as : List Bool) (H j : ℕ) (rows : List (ℕ × ℕ)) (ab sh av ah : ℕ),
    H < 2 ^ β →
    (region2L (β - 1) (2 ^ β - 1) 1 ys as H j rows ab).1 = (region2M β (2 ^ β - 1) ys H as j sh av ah ab).1 ∧
    (region2L (β - 1) (2 ^ β - 1) 1 ys as H j rows ab).2.2 = (region2M β (2 ^ β - 1) ys H as j sh av ah ab).2.2.2 ∧
    (region2L (β - 1) (2 ^ β - 1) 1 ys as H j rows ab).2.1 = (B_rows (2 ^ β - 1) ys as H).reverse ++ rows ∧
    (region2M β (2 ^ β - 1) ys H as j sh av ah ab).2.1 =
      av ||| (packRows β ((B_rows (2 ^ β - 1) ys as H).map Prod.fst) <<< sh) ∧
    (region2M β (2 ^ β - 1) ys H as j sh av ah ab).2.2.1 =
      ah ||| (packRows β ((B_rows (2 ^ β - 1) ys as H).map Prod.snd) <<< sh)
  | [], H, j, rows, ab, sh, av, ah, _ => by simp [region2L, region2M, B_rows, packRows]
  | a :: as, H, j, rows, ab, sh, av, ah, hH => by
    have hp : lineUpdL (2 ^ β - 1) (Bool.rec (motive := fun _ => ℕ) (Nat.xor ys (2 ^ β - 1)) ys a) H =
        lineUpdM (2 ^ β - 1) a ys H := by
      rw [lineUpdL_one hH, lineUpdM_sym]
    rw [B_region2L_cons, hp, Nat.and_one_is_mod]
    obtain ⟨i1, i2, i3, i4, i5⟩ := B_region2_eq ys as (lineUpdM (2 ^ β - 1) a ys H).1 (j + 1)
      (((lineUpdM (2 ^ β - 1) a ys H).2, (lineUpdM (2 ^ β - 1) a ys H).1) :: rows)
      (ab ||| ((((lineUpdM (2 ^ β - 1) a ys H).2 >>> (β - 1)) % 2) <<< j)) (sh + β)
      (av ||| ((lineUpdM (2 ^ β - 1) a ys H).2 <<< sh)) (ah ||| ((lineUpdM (2 ^ β - 1) a ys H).1 <<< sh))
      (lineUpdM_fst_lt hH a ys)
    simp only [region2M]
    refine ⟨i1, i2, ?_, ?_, ?_⟩
    · rw [i3]; simp [B_rows]
    · rw [i4]; simp only [B_rows, List.map_cons, packRows, or_shiftLeft_pack, Nat.or_assoc]
    · rw [i5]; simp only [B_rows, List.map_cons, packRows, or_shiftLeft_pack, Nat.or_assoc]

/-- Unpacking the rows of `packRows`. -/
theorem B_unpack (n : ℕ) : ∀ (Ls : List ℕ) (i : ℕ), (∀ x ∈ Ls, x < 2 ^ n) →
    (packRows n Ls >>> (n * i)) % 2 ^ n = Ls.getD i 0
  | [], i, _ => by simp [packRows]
  | x :: Ls, 0, hL => by
    have hx := hL x List.mem_cons_self
    apply Nat.eq_of_testBit_eq; intro b
    simp only [packRows, Nat.mul_zero, Nat.shiftRight_zero, List.getD_cons_zero, Nat.testBit_mod_two_pow,
      Nat.testBit_or, Nat.testBit_shiftLeft]
    by_cases hb : b < n
    · simp [hb, show ¬(b ≥ n) by omega]
    · simp [hb, testBit_false_of_lt_two_pow (i := b) hx (by omega)]
  | x :: Ls, i + 1, hL => by
    have hx := hL x List.mem_cons_self
    have ih := B_unpack n Ls i (fun y hy => hL y (List.mem_cons_of_mem _ hy))
    rw [List.getD_cons_succ, ← ih]
    apply Nat.eq_of_testBit_eq; intro b
    simp only [packRows, Nat.testBit_mod_two_pow, Nat.testBit_or, Nat.testBit_shiftLeft, Nat.testBit_shiftRight]
    by_cases hb : b < n
    · rw [testBit_false_of_lt_two_pow hx (by nlinarith)]
      simp [hb, show n * (i + 1) + b ≥ n by nlinarith, show n * (i + 1) + b - n = n * i + b by rw [Nat.mul_succ]; omega]
    · simp [hb]

theorem B_getD_map_fst (L : List (ℕ × ℕ)) (i : ℕ) : (L.map Prod.fst).getD i 0 = (L.getD i (0, 0)).1 := by
  simp only [List.getD_eq_getElem?_getD, List.getElem?_map]; cases L[i]? <;> rfl

theorem B_getD_map_snd (L : List (ℕ × ℕ)) (i : ℕ) : (L.map Prod.snd).getD i 0 = (L.getD i (0, 0)).2 := by
  simp only [List.getD_eq_getElem?_getD, List.getElem?_map]; cases L[i]? <;> rfl

/-! ### The traceback `traceInc` row by row -/

section Trace

variable {h : ℕ} (vert horiz : ℕ → ℕ → Bool)

theorem B_traceInc_fuel (hh : 1 ≤ h) : ∀ (f f' r s : ℕ), r + s < f → r + s < f' →
    traceInc h vert horiz f r s = traceInc h vert horiz f' r s
  | 0, _, _, _, hf, _ => absurd hf (by omega)
  | _ + 1, 0, _, _, _, hf' => absurd hf' (by omega)
  | f + 1, f' + 1, r, s, hf, hf' => by
    simp only [traceInc]
    by_cases h1 : r < h ∨ s < h
    · rw [ite_eq_left h1, ite_eq_left h1]
    · rw [ite_eq_right h1, ite_eq_right h1]
      rw [B_traceInc_fuel hh f f' (r - 1) s (by omega) (by omega),
        B_traceInc_fuel hh f f' r (s - 1) (by omega) (by omega),
        B_traceInc_fuel hh f f' (r - 1) (s - 1) (by omega) (by omega)]

/-- (T1a) A row above `h` without stop column in `[h, s]` rejects. -/
theorem B_trace_nostop {r : ℕ} (hr : h < r) :
    ∀ (f s : ℕ), (∀ c, h ≤ c → c ≤ s → vert r c = true ∧ horiz r c = false) → traceInc h vert horiz f r s = false
  | 0, _, _ => rfl
  | f + 1, s, hs => by
    simp only [traceInc]
    by_cases h1 : r < h ∨ s < h
    · rw [ite_eq_left h1]
    · rw [ite_eq_right h1, ite_eq_right (by omega : ¬(r = h ∧ s = h))]
      obtain ⟨hv, hz⟩ := hs s (by omega) le_rfl
      simp only [hv, hz, Bool.not_true, Bool.not_false, Bool.false_eq_true, ↓reduceIte]
      exact B_trace_nostop hr f (s - 1) (fun c hc1 hc2 => hs c hc1 (by omega))

/-- (T1b) A row above `h` is left at its highest stop column `c ≤ s`: up if `¬vert`, diagonally if `vert ∧ horiz`. -/
theorem B_trace_stop (hh : 1 ≤ h) {r c : ℕ} (hr : h < r) (hc : h ≤ c)
    (hstop : vert r c = false ∨ horiz r c = true) :
    ∀ (f s : ℕ), c ≤ s → r + s < f → (∀ c', c < c' → c' ≤ s → vert r c' = true ∧ horiz r c' = false) →
      traceInc h vert horiz f r s = traceInc h vert horiz (r + c) (r - 1) (if vert r c then c - 1 else c)
  | 0, _, _, hf, _ => absurd hf (by omega)
  | f + 1, s, hcs, hf, hs => by
    simp only [traceInc]
    rw [ite_eq_right (by omega : ¬(r < h ∨ s < h)), ite_eq_right (by omega : ¬(r = h ∧ s = h))]
    by_cases hsc : s = c
    · subst hsc
      cases hv : vert r s
      · simp only [Bool.not_false, ↓reduceIte, Bool.false_eq_true]
        exact B_traceInc_fuel vert horiz hh f (r + s) (r - 1) s (by omega) (by omega)
      · have hz : horiz r s = true := by
          rcases hstop with h' | h'
          · rw [hv] at h'; exact absurd h' (by simp)
          · exact h'
        simp only [hz, Bool.not_true, Bool.false_eq_true, ↓reduceIte]
        exact B_traceInc_fuel vert horiz hh f (r + s) (r - 1) (s - 1) (by omega) (by omega)
    · obtain ⟨hv, hz⟩ := hs s (by omega) le_rfl
      simp only [hv, hz, Bool.not_true, Bool.not_false, Bool.false_eq_true, ↓reduceIte]
      exact B_trace_stop hh hr hc hstop f (s - 1) (by omega) (by omega) (fun c' h1 h2 => hs c' h1 (by omega))

theorem B_trace_below (hh : 1 ≤ h) : ∀ f s, traceInc h vert horiz f (h - 1) s = false
  | 0, _ => rfl
  | f + 1, s => by simp only [traceInc]; rw [ite_eq_left (Or.inl (by omega))]

/-- (T2) Row `h`: accept iff `s ≥ h` and no stop column in `(h, s]`. -/
theorem B_trace_rowh (hh : 1 ≤ h) : ∀ (f s : ℕ), h + s < f →
    (traceInc h vert horiz f h s = true ↔ (h ≤ s ∧ ∀ c, h < c → c ≤ s → vert h c = true ∧ horiz h c = false))
  | 0, _, hf => absurd hf (by omega)
  | f + 1, s, hf => by
    rw [traceInc]
    by_cases hs : s < h
    · rw [ite_eq_left (Or.inr hs)]
      simp only [Bool.false_eq_true, false_iff, not_and]; intro h1; omega
    · rw [ite_eq_right (by omega)]
      by_cases hsh : s = h
      · rw [ite_eq_left ⟨rfl, hsh⟩]
        simp only [true_iff]; exact ⟨by omega, fun c h1 h2 => by omega⟩
      · rw [ite_eq_right (by omega)]
        cases hv : vert h s
        · simp only [Bool.not_false, ↓reduceIte, B_trace_below vert horiz hh, Bool.false_eq_true, false_iff]
          rintro ⟨-, hall⟩
          have := (hall s (by omega) le_rfl).1; rw [hv] at this; exact absurd this (by simp)
        · cases hz : horiz h s
          · simp only [Bool.not_true, Bool.not_false, Bool.false_eq_true, ↓reduceIte]
            rw [B_trace_rowh hh f (s - 1) (by omega)]
            constructor
            · rintro ⟨-, hall⟩
              refine ⟨by omega, fun c h1 h2 => ?_⟩
              by_cases hcs : c = s
              · subst hcs; exact ⟨hv, hz⟩
              · exact hall c h1 (by omega)
            · rintro ⟨-, hall⟩
              exact ⟨by omega, fun c h1 h2 => hall c h1 (by omega)⟩
          · simp only [Bool.not_true, Bool.false_eq_true, ↓reduceIte, B_trace_below vert horiz hh, false_iff]
            rintro ⟨-, hall⟩
            have := (hall s (by omega) le_rfl).2; rw [hz] at this; exact absurd this (by simp)

end Trace

/-! ### The packed row step -/

/-- The position mask of column `s` (bit `s - 1`; `0` for column `0`). -/
def B_enc (s : ℕ) : ℕ := 2 ^ s >>> 1

theorem B_testBit_enc (s b : ℕ) : (B_enc s).testBit b = decide (b + 1 = s) := by
  unfold B_enc
  rw [Nat.testBit_shiftRight, Nat.testBit_two_pow]
  by_cases hb : b + 1 = s
  · rw [decide_eq_true hb, decide_eq_true (by omega)]
  · rw [decide_eq_false hb, decide_eq_false (by omega)]

theorem B_enc_lt {s β : ℕ} (hs : s ≤ β) : B_enc s < 2 ^ β :=
  Nat.lt_pow_two_of_testBit _ fun i hi => by rw [B_testBit_enc]; exact decide_eq_false (by omega)

theorem B_enc_pos {s : ℕ} (hs : 1 ≤ s) : B_enc s = 2 ^ (s - 1) := by
  apply Nat.eq_of_testBit_eq; intro b
  rw [B_testBit_enc, Nat.testBit_two_pow]
  by_cases hb : b + 1 = s
  · rw [decide_eq_true hb, decide_eq_true (by omega)]
  · rw [decide_eq_false hb, decide_eq_false (by omega)]

theorem B_eq_zero_iff (z : ℕ) : z = 0 ↔ ∀ b, z.testBit b = false :=
  ⟨fun h b => by subst h; exact Nat.zero_testBit b, fun h => Nat.eq_of_testBit_eq fun b => by rw [h b, Nat.zero_testBit]⟩

theorem B_testBit_two_pow_sub_two_pow {a β : ℕ} (hab : a ≤ β) (b : ℕ) :
    (2 ^ β - 2 ^ a).testBit b = decide (a ≤ b ∧ b < β) := by
  have : 2 ^ β - 2 ^ a = (2 ^ (β - a) - 1) <<< a := by
    rw [Nat.shiftLeft_eq, Nat.sub_mul, one_mul, ← pow_add, Nat.sub_add_cancel hab]
  rw [this, Nat.testBit_shiftLeft, Nat.testBit_two_pow_sub_one]
  by_cases h1 : a ≤ b
  · by_cases h2 : b < β
    · rw [decide_eq_true (show b ≥ a from h1), decide_eq_true (show b - a < β - a by omega), decide_eq_true ⟨h1, h2⟩]
      rfl
    · rw [decide_eq_false (show ¬(b - a < β - a) by omega), decide_eq_false (show ¬(a ≤ b ∧ b < β) by omega)]; simp
  · rw [decide_eq_false (show ¬(b ≥ a) from h1), decide_eq_false (show ¬(a ≤ b ∧ b < β) by omega)]; rfl

theorem B_fillDown_one {w z : ℕ} (hw : w ≤ 32) (hz : z < 2 ^ w) :
    fillDownL (2 ^ w - 1) z &&& 1 = if z = 0 then 0 else 1 := by
  rw [fillDownL_eq hw hz]
  split_ifs with h0
  · rfl
  · rw [Nat.and_one_is_mod]
    have h1 : 2 ^ (z.log2 + 1) = 2 * 2 ^ z.log2 := by rw [pow_succ]; ring
    have h2 : 1 ≤ 2 ^ z.log2 := Nat.one_le_two_pow
    omega

theorem B_fillDown_enc {β s : ℕ} (hβ : β ≤ 32) (hs : s ≤ β) (b : ℕ) :
    (fillDownL (2 ^ β - 1) (B_enc s)).testBit b = decide (b < s) := by
  rw [Bool.eq_iff_iff, testBit_fillDownL hβ (B_enc_lt hs), decide_eq_true_iff]
  simp only [B_testBit_enc, decide_eq_true_eq]
  constructor
  · rintro ⟨-, i, h1, h2⟩; omega
  · intro hb; exact ⟨by omega, s - 1, by omega, by omega⟩

/-- The stop columns `h … s` of a row (as in `traceRowsL`). -/
noncomputable def B_q (fullb geh v hz pos : ℕ) : ℕ := (((v ^^^ fullb) ||| hz) &&& fillDownL fullb pos) &&& geh

/-- The highest set bit of a filled mask. -/
def B_stop (fullb f : ℕ) : ℕ := f &&& (f ^^^ ((f >>> 1) &&& fullb))

/-- The new position after leaving a row at the stop bit `stop`. -/
def B_npos (fullb v stop : ℕ) : ℕ := (stop ^^^ (v &&& stop)) ||| (((v &&& stop) >>> 1) &&& fullb)

theorem B_traceRowsL_cons (fullb geh one : ℕ) (vh : ℕ × ℕ) (rows : List (ℕ × ℕ)) (alive pos : ℕ) :
    traceRowsL fullb geh one (vh :: rows) alive pos =
      traceRowsL fullb geh one rows ((alive &&& fillDownL fullb (B_q fullb geh vh.1 vh.2 pos)) &&& one)
        (B_npos fullb vh.1 (B_stop fullb (fillDownL fullb (B_q fullb geh vh.1 vh.2 pos)))) := rfl

theorem B_traceRowsL_dead (fullb geh : ℕ) :
    ∀ (rows : List (ℕ × ℕ)) (pos : ℕ), (traceRowsL fullb geh 1 rows 0 pos).1 = 0
  | [], _ => rfl
  | vh :: rows, pos => by
    rw [B_traceRowsL_cons, Nat.zero_and, Nat.zero_and]; exact B_traceRowsL_dead fullb geh rows _

theorem B_testBit_q {h β s : ℕ} (hh : 1 ≤ h) (hhβ : h ≤ β) (hβ : β ≤ 32) (hs : s ≤ β) (v hz b : ℕ) :
    (B_q (2 ^ β - 1) (2 ^ β - 2 ^ (h - 1)) v hz (B_enc s)).testBit b =
      ((!v.testBit b || hz.testBit b) && decide (h - 1 ≤ b ∧ b < s)) := by
  unfold B_q
  rw [Nat.testBit_and, Nat.testBit_and, Nat.testBit_or, Nat.testBit_xor, Nat.testBit_two_pow_sub_one,
    B_fillDown_enc hβ hs, B_testBit_two_pow_sub_two_pow (by omega : h - 1 ≤ β)]
  by_cases h2 : b < s
  · rw [decide_eq_true (show b < β by omega), decide_eq_true h2]
    by_cases h1 : h - 1 ≤ b
    · rw [decide_eq_true ⟨h1, show b < β by omega⟩, decide_eq_true ⟨h1, h2⟩]; simp
    · rw [decide_eq_false (show ¬(h - 1 ≤ b ∧ b < β) by omega), decide_eq_false (show ¬(h - 1 ≤ b ∧ b < s) by omega)]
      simp
  · rw [decide_eq_false h2, decide_eq_false (show ¬(h - 1 ≤ b ∧ b < s) by omega)]; simp

theorem B_row_none {h β s : ℕ} (hh : 1 ≤ h) (hhβ : h ≤ β) (hβ : β ≤ 32) {v hz : ℕ} (hs : s ≤ β)
    (hnone : ∀ c, h ≤ c → c ≤ s → v.testBit (c - 1) = true ∧ hz.testBit (c - 1) = false) :
    fillDownL (2 ^ β - 1) (B_q (2 ^ β - 1) (2 ^ β - 2 ^ (h - 1)) v hz (B_enc s)) &&& 1 = 0 := by
  have hq0 : B_q (2 ^ β - 1) (2 ^ β - 2 ^ (h - 1)) v hz (B_enc s) = 0 := by
    rw [B_eq_zero_iff]; intro b
    rw [B_testBit_q hh hhβ hβ hs]
    by_cases hb : h - 1 ≤ b ∧ b < s
    · obtain ⟨hv, hz'⟩ := hnone (b + 1) (by omega) (by omega)
      rw [Nat.add_sub_cancel] at hv hz'
      rw [hv, hz']; simp
    · rw [decide_eq_false hb]; simp
  rw [hq0, fillDownL_eq hβ (by positivity)]; simp

theorem B_row_stop {h β s c : ℕ} (hh : 1 ≤ h) (hhβ : h ≤ β) (hβ : β ≤ 32) {v hz : ℕ} (hs : s ≤ β) (hc : h ≤ c)
    (hcs : c ≤ s) (hstop : v.testBit (c - 1) = false ∨ hz.testBit (c - 1) = true)
    (hmax : ∀ c', c < c' → c' ≤ s → v.testBit (c' - 1) = true ∧ hz.testBit (c' - 1) = false) :
    fillDownL (2 ^ β - 1) (B_q (2 ^ β - 1) (2 ^ β - 2 ^ (h - 1)) v hz (B_enc s)) &&& 1 = 1 ∧
    B_npos (2 ^ β - 1) v (B_stop (2 ^ β - 1) (fillDownL (2 ^ β - 1) (B_q (2 ^ β - 1) (2 ^ β - 2 ^ (h - 1)) v hz
      (B_enc s)))) = B_enc (if v.testBit (c - 1) then c - 1 else c) := by
  have hq := B_testBit_q hh hhβ hβ hs v hz
  generalize B_q (2 ^ β - 1) (2 ^ β - 2 ^ (h - 1)) v hz (B_enc s) = q at hq ⊢
  have hqlt : q < 2 ^ β := by
    apply Nat.lt_pow_two_of_testBit; intro i hi; rw [hq]
    rw [decide_eq_false (show ¬(h - 1 ≤ i ∧ i < s) by omega)]; simp
  have hf : ∀ b, (fillDownL (2 ^ β - 1) q).testBit b = decide (b < c) := by
    intro b
    rw [Bool.eq_iff_iff, testBit_fillDownL hβ hqlt, decide_eq_true_iff]
    constructor
    · rintro ⟨hb, i, hbi, hi⟩
      rw [hq] at hi
      by_contra hbc
      simp only [Bool.and_eq_true, Bool.or_eq_true, Bool.not_eq_true', decide_eq_true_eq] at hi
      obtain ⟨hstop', h1, h2⟩ := hi
      obtain ⟨hv', hz'⟩ := hmax (i + 1) (by omega) (by omega)
      rw [Nat.add_sub_cancel] at hv' hz'
      rcases hstop' with h' | h'
      · rw [hv'] at h'; exact absurd h' (by simp)
      · rw [hz'] at h'; exact absurd h' (by simp)
    · intro hb
      refine ⟨by omega, c - 1, by omega, ?_⟩
      rw [hq]
      simp only [Bool.and_eq_true, Bool.or_eq_true, Bool.not_eq_true', decide_eq_true_eq]
      exact ⟨hstop, by omega, by omega⟩
  generalize fillDownL (2 ^ β - 1) q = f at hf ⊢
  have hstopb : ∀ b, (B_stop (2 ^ β - 1) f).testBit b = decide (b + 1 = c) := by
    intro b
    unfold B_stop
    rw [Nat.testBit_and, Nat.testBit_xor, Nat.testBit_and, Nat.testBit_shiftRight, Nat.testBit_two_pow_sub_one, hf, hf]
    rcases Nat.lt_trichotomy (b + 1) c with h1 | h1 | h1
    · rw [decide_eq_true (show b < c by omega), decide_eq_true (show 1 + b < c by omega),
        decide_eq_true (show b < β by omega), decide_eq_false (show ¬(b + 1 = c) by omega)]; rfl
    · rw [decide_eq_true (show b < c by omega), decide_eq_false (show ¬(1 + b < c) by omega),
        decide_eq_true h1]; rfl
    · rw [decide_eq_false (show ¬(b < c) by omega), decide_eq_false (show ¬(b + 1 = c) by omega)]; rfl
  refine ⟨?_, ?_⟩
  · have h0 := hf 0
    rw [Nat.testBit_zero, decide_eq_decide] at h0
    rw [Nat.and_one_is_mod]; exact h0.mpr (by omega)
  · apply Nat.eq_of_testBit_eq; intro b
    unfold B_npos
    rw [B_testBit_enc, Nat.testBit_or, Nat.testBit_xor, Nat.testBit_and, Nat.testBit_and, Nat.testBit_shiftRight,
      Nat.testBit_and, Nat.testBit_two_pow_sub_one, hstopb, hstopb]
    cases hvc : v.testBit (c - 1)
    · simp only [Bool.false_eq_true, ↓reduceIte]
      by_cases h1 : b + 1 = c
      · have : v.testBit b = false := by rw [show b = c - 1 by omega]; exact hvc
        rw [this, decide_eq_true h1, decide_eq_false (show ¬(1 + b + 1 = c) by omega)]; simp
      · by_cases h2 : 1 + b + 1 = c
        · have : v.testBit (1 + b) = false := by rw [show 1 + b = c - 1 by omega]; exact hvc
          rw [this, decide_eq_false h1]; simp
        · rw [decide_eq_false h1, decide_eq_false h2]; simp
    · simp only [↓reduceIte]
      by_cases h1 : b + 1 = c
      · have : v.testBit b = true := by rw [show b = c - 1 by omega]; exact hvc
        rw [this, decide_eq_true h1, decide_eq_false (show ¬(1 + b + 1 = c) by omega),
          decide_eq_false (show ¬(b + 1 = c - 1) by omega)]; simp
      · by_cases h2 : 1 + b + 1 = c
        · have : v.testBit (1 + b) = true := by rw [show 1 + b = c - 1 by omega]; exact hvc
          rw [this, decide_eq_false h1, decide_eq_true h2, decide_eq_true (show b < β by omega),
            decide_eq_true (show b + 1 = c - 1 by omega)]; simp
        · rw [decide_eq_false h1, decide_eq_false h2, decide_eq_false (show ¬(b + 1 = c - 1) by omega)]; simp

/-! ### The packed traceback -/

/-- The final acceptance of `kstepLeafL` from the traceback state `t` (row-`h` test). -/
noncomputable def B_final (h β A B : ℕ) (t : ℕ × ℕ) : ℕ :=
  (t.1 &&& (fillDownL (2 ^ β - 1) (t.2 &&& (2 ^ β - 2 ^ (h - 1))) &&& 1)) &&&
    ((fillDownL (2 ^ β - 1) (((((A <<< h) ^^^ (2 ^ β - 1)) ||| (B <<< h)) &&& (2 ^ β - 2 ^ h)) &&&
      fillDownL (2 ^ β - 1) t.2) &&& 1) ^^^ 1)

theorem B_final_dead (h β A B : ℕ) (t : ℕ × ℕ) (ht : t.1 = 0) : B_final h β A B t = 0 := by
  simp only [B_final, ht, Nat.zero_and]

theorem B_final_alive {h β A B s : ℕ} (hh : 1 ≤ h) (hhβ : h ≤ β) (hβ : β ≤ 32) (hs : s ≤ β) :
    (B_final h β A B (1, B_enc s) = 1 ↔
      (h ≤ s ∧ ∀ c, h < c → c ≤ s → A.testBit (c - h - 1) = true ∧ B.testBit (c - h - 1) = false)) ∧
    B_final h β A B (1, B_enc s) ≤ 1 := by
  have hz1 : (B_enc s &&& (2 ^ β - 2 ^ (h - 1))) = 0 ↔ ¬(h ≤ s) := by
    rw [B_eq_zero_iff]
    constructor
    · intro hall hhs
      have := hall (s - 1)
      rw [Nat.testBit_and, B_testBit_enc, B_testBit_two_pow_sub_two_pow (by omega),
        decide_eq_true (show s - 1 + 1 = s by omega), decide_eq_true (show h - 1 ≤ s - 1 ∧ s - 1 < β by omega)] at this
      exact absurd this (by simp)
    · intro hhs b
      rw [Nat.testBit_and, B_testBit_enc]
      by_cases hb : b + 1 = s
      · rw [B_testBit_two_pow_sub_two_pow (by omega), decide_eq_false (show ¬(h - 1 ≤ b ∧ b < β) by omega)]; simp
      · rw [decide_eq_false hb]; simp
  have hz2 : ((((A <<< h) ^^^ (2 ^ β - 1)) ||| (B <<< h)) &&& (2 ^ β - 2 ^ h)) &&&
      fillDownL (2 ^ β - 1) (B_enc s) = 0 ↔
      (∀ c, h < c → c ≤ s → A.testBit (c - h - 1) = true ∧ B.testBit (c - h - 1) = false) := by
    rw [B_eq_zero_iff]
    constructor
    · intro hall c h1 h2
      have := hall (c - 1)
      rw [Nat.testBit_and, Nat.testBit_and, Nat.testBit_or, Nat.testBit_xor, Nat.testBit_shiftLeft,
        Nat.testBit_shiftLeft, Nat.testBit_two_pow_sub_one, B_testBit_two_pow_sub_two_pow hhβ, B_fillDown_enc hβ hs,
        decide_eq_true (show c - 1 ≥ h by omega), decide_eq_true (show c - 1 < β by omega),
        decide_eq_true (show h ≤ c - 1 ∧ c - 1 < β by omega), decide_eq_true (show c - 1 < s by omega),
        show c - 1 - h = c - h - 1 by omega] at this
      cases hA : A.testBit (c - h - 1) <;> cases hB : B.testBit (c - h - 1) <;> simp_all
    · intro hall b
      rw [Nat.testBit_and, Nat.testBit_and, Nat.testBit_or, Nat.testBit_xor, Nat.testBit_shiftLeft,
        Nat.testBit_shiftLeft, Nat.testBit_two_pow_sub_one, B_testBit_two_pow_sub_two_pow hhβ, B_fillDown_enc hβ hs]
      by_cases hb : h ≤ b ∧ b < β ∧ b < s
      · obtain ⟨hA, hB⟩ := hall (b + 1) (by omega) (by omega)
        rw [show b + 1 - h - 1 = b - h by omega] at hA hB
        rw [decide_eq_true (show b ≥ h by omega), decide_eq_true (show b < β by omega),
          decide_eq_true (show h ≤ b ∧ b < β by omega), decide_eq_true (show b < s by omega), hA, hB]; rfl
      · by_cases hb2 : h ≤ b ∧ b < β
        · rw [decide_eq_true hb2, decide_eq_false (show ¬(b < s) by omega)]; simp
        · rw [decide_eq_false hb2]; simp
  have hlt1 : B_enc s &&& (2 ^ β - 2 ^ (h - 1)) < 2 ^ β := lt_of_le_of_lt Nat.and_le_left (B_enc_lt hs)
  have hlt2 : ((((A <<< h) ^^^ (2 ^ β - 1)) ||| (B <<< h)) &&& (2 ^ β - 2 ^ h)) &&&
      fillDownL (2 ^ β - 1) (B_enc s) < 2 ^ β := lt_of_le_of_lt Nat.and_le_right (fillDownL_lt hβ (B_enc_lt hs))
  unfold B_final
  dsimp only
  rw [B_fillDown_one hβ hlt1, B_fillDown_one hβ hlt2]
  by_cases c1 : B_enc s &&& (2 ^ β - 2 ^ (h - 1)) = 0
  · have := hz1.mp c1
    rw [ite_eq_left c1]
    simp only [Nat.and_zero, Nat.zero_and]
    exact ⟨iff_of_false (by decide) (fun hP => this hP.1), by decide⟩
  · rw [ite_eq_right c1]
    have hs' : h ≤ s := by by_contra h'; exact c1 (hz1.mpr h')
    by_cases c2 : ((((A <<< h) ^^^ (2 ^ β - 1)) ||| (B <<< h)) &&& (2 ^ β - 2 ^ h)) &&&
        fillDownL (2 ^ β - 1) (B_enc s) = 0
    · rw [ite_eq_left c2]
      exact ⟨iff_of_true (by decide) ⟨hs', hz2.mp c2⟩, by decide⟩
    · rw [ite_eq_right c2]
      exact ⟨iff_of_false (by decide) (fun hP => c2 (hz2.mpr hP.2)), by decide⟩

theorem B_exists_max (P : ℕ → Prop) : ∀ s, (∃ c ≤ s, P c) → ∃ c ≤ s, P c ∧ ∀ c', c < c' → c' ≤ s → ¬ P c'
  | 0, ⟨c, hc, hP⟩ => ⟨c, hc, hP, fun c' h1 h2 => by omega⟩
  | s + 1, ⟨c, hc, hP⟩ => by
    by_cases hs : P (s + 1)
    · exact ⟨s + 1, le_rfl, hs, fun c' h1 h2 => by omega⟩
    · have hc' : c ≤ s := by
        rcases Nat.lt_or_ge c (s + 1) with h' | h'
        · omega
        · exfalso; have : c = s + 1 := by omega
          subst this; exact hs hP
      obtain ⟨d, hd, hPd, hmax⟩ := B_exists_max P s ⟨c, hc', hP⟩
      refine ⟨d, by omega, hPd, fun c' h1 h2 => ?_⟩
      rcases Nat.lt_or_ge c' (s + 1) with h' | h'
      · exact hmax c' h1 (by omega)
      · have : c' = s + 1 := by omega
        subst this; exact hs

theorem B_take_succ_reverse {α : Type} (RS : List α) (m : ℕ) (hm : m < RS.length) (d : α) :
    (RS.take (m + 1)).reverse = RS.getD m d :: (RS.take m).reverse := by
  rw [List.take_add_one, List.getElem?_eq_getElem hm, Option.toList_some, List.reverse_append, List.reverse_singleton,
    List.singleton_append, List.getD_eq_getElem?_getD, List.getElem?_eq_getElem hm, Option.getD_some]

/-- (T4) The packed traceback through the rows `h + m, …, h + 1` (lane alive at column `s`) followed by the row-`h`
test computes `traceInc` from `(h + m, s)`. -/
theorem B_trace_rows {h β : ℕ} (hh : 1 ≤ h) (hhβ : h ≤ β) (hβ : β ≤ 32) (vert horiz : ℕ → ℕ → Bool)
    (RS : List (ℕ × ℕ))
    (hRv : ∀ i < RS.length, ∀ c, 1 ≤ c → vert (h + 1 + i) c = (RS.getD i (0, 0)).1.testBit (c - 1))
    (hRz : ∀ i < RS.length, ∀ c, 1 ≤ c → horiz (h + 1 + i) c = (RS.getD i (0, 0)).2.testBit (c - 1))
    (A B : ℕ) (hA : ∀ c, h < c → vert h c = A.testBit (c - h - 1))
    (hB : ∀ c, h < c → horiz h c = B.testBit (c - h - 1)) :
    ∀ m ≤ RS.length, ∀ s ≤ β,
      B_final h β A B (traceRowsL (2 ^ β - 1) (2 ^ β - 2 ^ (h - 1)) 1 (RS.take m).reverse 1 (B_enc s)) =
        if traceInc h vert horiz (h + m + s + 1) (h + m) s then 1 else 0 := by
  intro m
  induction m with
  | zero =>
    intro _ s hs
    rw [List.take_zero, List.reverse_nil]
    show B_final h β A B (1, B_enc s) = if traceInc h vert horiz (h + s + 1) h s then 1 else 0
    obtain ⟨hiff, hle⟩ := B_final_alive (A := A) (B := B) hh hhβ hβ hs
    have hT := B_trace_rowh vert horiz hh (h + s + 1) s (by omega)
    by_cases ht : traceInc h vert horiz (h + s + 1) h s = true
    · rw [ite_eq_left ht]; apply hiff.mpr
      obtain ⟨h1, h2⟩ := hT.mp ht
      refine ⟨h1, fun c hc1 hc2 => ?_⟩
      rw [← hA c hc1, ← hB c hc1]; exact h2 c hc1 hc2
    · rw [ite_eq_right ht]
      have : B_final h β A B (1, B_enc s) ≠ 1 := by
        intro h1
        obtain ⟨h2, h3⟩ := hiff.mp h1
        exact ht (hT.mpr ⟨h2, fun c hc1 hc2 => by rw [hA c hc1, hB c hc1]; exact h3 c hc1 hc2⟩)
      omega
  | succ m ih =>
    intro hm s hs
    rw [B_take_succ_reverse RS m (by omega) (0, 0), B_traceRowsL_cons]
    have hr : h < h + (m + 1) := by omega
    have hv : ∀ c, 1 ≤ c → vert (h + (m + 1)) c = (RS.getD m (0, 0)).1.testBit (c - 1) := fun c hc => by
      rw [show h + (m + 1) = h + 1 + m by omega]; exact hRv m (by omega) c hc
    have hz : ∀ c, 1 ≤ c → horiz (h + (m + 1)) c = (RS.getD m (0, 0)).2.testBit (c - 1) := fun c hc => by
      rw [show h + (m + 1) = h + 1 + m by omega]; exact hRz m (by omega) c hc
    by_cases hex : ∃ c ≤ s, h ≤ c ∧ (vert (h + (m + 1)) c = false ∨ horiz (h + (m + 1)) c = true)
    · obtain ⟨c, hcs, ⟨hc, hstop⟩, hmax⟩ := B_exists_max _ s hex
      have hmax' : ∀ c', c < c' → c' ≤ s → vert (h + (m + 1)) c' = true ∧ horiz (h + (m + 1)) c' = false := by
        intro c' h1 h2
        have := hmax c' h1 h2
        refine ⟨?_, ?_⟩
        · by_contra hcon; exact this ⟨by omega, Or.inl (by simpa using hcon)⟩
        · by_contra hcon; exact this ⟨by omega, Or.inr (by simpa using hcon)⟩
      obtain ⟨hal, hpos⟩ := B_row_stop (v := (RS.getD m (0, 0)).1) (hz := (RS.getD m (0, 0)).2) hh hhβ hβ hs hc hcs
        (by rw [← hv c (by omega), ← hz c (by omega)]; exact hstop)
        (fun c' h1 h2 => by rw [← hv c' (by omega), ← hz c' (by omega)]; exact hmax' c' h1 h2)
      rw [Nat.and_assoc, hal, hpos, show (1 &&& 1 : ℕ) = 1 from rfl,
        ih (by omega) (if (RS.getD m (0, 0)).1.testBit (c - 1) then c - 1 else c) (by split <;> omega)]
      rw [B_trace_stop vert horiz hh hr hc hstop (h + (m + 1) + s + 1) s hcs (by omega) hmax',
        ← hv c (by omega), show h + (m + 1) - 1 = h + m by omega]
      rw [B_traceInc_fuel vert horiz hh (h + (m + 1) + c)
        (h + m + (if vert (h + (m + 1)) c then c - 1 else c) + 1) (h + m) _ (by split <;> omega) (by omega)]
    · have hnone : ∀ c, h ≤ c → c ≤ s → vert (h + (m + 1)) c = true ∧ horiz (h + (m + 1)) c = false := by
        intro c h1 h2
        by_contra hcon
        apply hex
        refine ⟨c, h2, h1, ?_⟩
        cases hv' : vert (h + (m + 1)) c <;> cases hz' : horiz (h + (m + 1)) c <;> simp_all
      have hal := B_row_none (v := (RS.getD m (0, 0)).1) (hz := (RS.getD m (0, 0)).2) hh hhβ hβ hs
        (fun c h1 h2 => by rw [← hv c (by omega), ← hz c (by omega)]; exact hnone c h1 h2)
      rw [Nat.and_assoc, hal, Nat.and_zero, B_final_dead _ _ _ _ _ (B_traceRowsL_dead _ _ _ _),
        B_trace_nostop vert horiz hr _ s hnone]
      rfl

/-- (T4) with all rows, in the form of `kstep`'s increment functions. -/
theorem B_trace_kstep {h β nt : ℕ} (hh : 1 ≤ h) (hhβ : h ≤ β) (hβ : β ≤ 32) (A B : ℕ) (RS : List (ℕ × ℕ))
    (hRS : ∀ p ∈ RS, p.1 < 2 ^ β ∧ p.2 < 2 ^ β) (hlen : RS.length = nt) :
    B_final h β A B (traceRowsL (2 ^ β - 1) (2 ^ β - 2 ^ (h - 1)) 1 RS.reverse 1 (B_enc β)) =
      if traceInc h
          (fun r s => if r ≤ h then A.testBit (s - h - 1)
            else ((packRows β (RS.map Prod.fst) >>> (β * (r - h - 1))) % 2 ^ β).testBit (s - 1))
          (fun r s => if r ≤ h then B.testBit (s - h - 1)
            else ((packRows β (RS.map Prod.snd) >>> (β * (r - h - 1))) % 2 ^ β).testBit (s - 1))
          (h + nt + β + 1) (h + nt) β then 1 else 0 := by
  subst hlen
  have h1 : ∀ x ∈ RS.map Prod.fst, x < 2 ^ β := by
    intro x hx; obtain ⟨p, hp, rfl⟩ := List.mem_map.mp hx; exact (hRS p hp).1
  have h2 : ∀ x ∈ RS.map Prod.snd, x < 2 ^ β := by
    intro x hx; obtain ⟨p, hp, rfl⟩ := List.mem_map.mp hx; exact (hRS p hp).2
  have := B_trace_rows hh hhβ hβ
    (fun r s => if r ≤ h then A.testBit (s - h - 1)
      else ((packRows β (RS.map Prod.fst) >>> (β * (r - h - 1))) % 2 ^ β).testBit (s - 1))
    (fun r s => if r ≤ h then B.testBit (s - h - 1)
      else ((packRows β (RS.map Prod.snd) >>> (β * (r - h - 1))) % 2 ^ β).testBit (s - 1)) RS
    (fun i hi c hc => by
      simp only [show ¬(h + 1 + i ≤ h) by omega, ↓reduceIte, show h + 1 + i - h - 1 = i by omega, B_unpack β _ i h1,
        B_getD_map_fst])
    (fun i hi c hc => by
      simp only [show ¬(h + 1 + i ≤ h) by omega, ↓reduceIte, show h + 1 + i - h - 1 = i by omega, B_unpack β _ i h2,
        B_getD_map_snd])
    A B (fun c hc => by simp only [le_refl, ↓reduceIte]) (fun c hc => by simp only [le_refl, ↓reduceIte])
    RS.length le_rfl β le_rfl
  rwa [List.take_length] at this

theorem B_final_fold (h β A B : ℕ) (t : ℕ × ℕ) :
    (t.1 &&& (fillDownL (2 ^ β - 1) (t.2 &&& (2 ^ β - 2 ^ (h - 1))) &&& 1)) &&&
      ((fillDownL (2 ^ β - 1) (((((A <<< h) ^^^ (2 ^ β - 1)) ||| (B <<< h)) &&& (2 ^ β - 2 ^ h)) &&&
        fillDownL (2 ^ β - 1) t.2) &&& 1) ^^^ 1) = B_final h β A B t := rfl

/-! ### The codes -/

theorem B_revBits_congr {h z z' : ℕ} (hzz : ∀ b < h, z.testBit b = z'.testBit b) : revBits h z 0 = revBits h z' 0 := by
  apply Nat.eq_of_testBit_eq; intro b
  rw [testBit_revBits, testBit_revBits]
  by_cases hb : b < h
  · rw [hzz (h - 1 - b) (by omega)]
  · simp [hb]

theorem B_packCode_eq {h a b c d : ℕ} (hb : b < 2 ^ h) (hc : c < 2 ^ h) (hd : d < 2 ^ h) :
    packCode h a b c d = (((a <<< (3 * h)) ||| (b <<< (2 * h))) ||| (c <<< h)) ||| d := by
  unfold packCode
  have e1 : ∀ x y, y < 2 ^ h → x * 2 ^ h + y = (x <<< h) ||| y := fun x y hy => by
    rw [← Nat.shiftLeft_eq]; exact Nat.shiftLeft_add_eq_or_of_lt hy x
  rw [e1 a b hb, e1 _ c hc, e1 _ d hd]
  rw [show 3 * h = h + h + h by ring, show 2 * h = h + h by ring, Nat.shiftLeft_add, Nat.shiftLeft_add,
    Nat.shiftLeft_add, Nat.shiftLeft_or_distrib, Nat.shiftLeft_or_distrib, Nat.shiftLeft_or_distrib]

theorem B_code {h : ℕ} (hh1 : 1 ≤ h) (hh : h ≤ 16) (X Y DX DY : ℕ) :
    (((revLanesL 1 h ((X &&& (2 ^ h - 1)) ^^^ spreadL (2 ^ h - 1) ((X &&& (2 ^ h - 1)) &&& 1)) <<< (3 * h)) |||
      (revLanesL 1 h ((Y &&& (2 ^ h - 1)) ^^^ spreadL (2 ^ h - 1) ((X &&& (2 ^ h - 1)) &&& 1)) <<< (2 * h))) |||
      (revLanesL 1 h (DX &&& (2 ^ h - 1)) <<< h)) ||| revLanesL 1 h (DY &&& (2 ^ h - 1)) =
    packCode h (revBits h (if X % 2 = 1 then X ^^^ (2 ^ h - 1) else X) 0)
      (revBits h (if X % 2 = 1 then Y ^^^ (2 ^ h - 1) else Y) 0) (revBits h DX 0) (revBits h DY 0) := by
  have hm : (X &&& (2 ^ h - 1)) &&& 1 = X % 2 := by
    have h2 : (2 ^ h - 1) &&& 1 = 1 := by
      rw [Nat.and_one_is_mod]
      have : 2 ^ h = 2 * 2 ^ (h - 1) := by rw [← pow_succ']; congr 1; omega
      have : 1 ≤ 2 ^ (h - 1) := Nat.one_le_two_pow
      omega
    rw [Nat.and_assoc, h2, Nat.and_one_is_mod]
  rw [hm, spreadL_eq (by omega) (by omega : X % 2 ≤ 1), revLanesL_one_eq (by omega), revLanesL_one_eq (by omega),
    revLanesL_one_eq (by omega), revLanesL_one_eq (by omega)]
  rw [B_packCode_eq (revBits_lt _ _) (revBits_lt _ _) (revBits_lt _ _)]
  have hc : ∀ Z, revBits h (Z &&& (2 ^ h - 1)) 0 = revBits h Z 0 := fun Z => B_revBits_congr fun b hb => by
    rw [Nat.testBit_and, Nat.testBit_two_pow_sub_one, decide_eq_true hb, Bool.and_true]
  have hx : ∀ Z, revBits h ((Z &&& (2 ^ h - 1)) ^^^ (if X % 2 = 1 then 2 ^ h - 1 else 0)) 0 =
      revBits h (if X % 2 = 1 then Z ^^^ (2 ^ h - 1) else Z) 0 := by
    intro Z
    split_ifs
    · apply B_revBits_congr; intro b hb
      rw [Nat.testBit_xor, Nat.testBit_and, Nat.testBit_xor, Nat.testBit_two_pow_sub_one, decide_eq_true hb,
        Bool.and_true]
    · rw [Nat.xor_zero, hc]
  rw [hx, hx, hc, hc]

theorem B_botStr_length_le {h : ℕ} {c : Bool} {l : ℤ} (hl : l.natAbs < h) : (botStr c l).length ≤ h := by
  unfold botStr; split_ifs <;> simp <;> omega

/-! ### The main theorem -/

theorem kstepLeafL_one {h : ℕ} (k : ℕ) (hh1 : 1 ≤ h) (hh : h ≤ 16) (c : Bool) (l : ℤ) (hl : l.natAbs < h) :
    (kstepLeafL h 1 k c l).1 ≤ 1 ∧
      kstep h k c l = if (kstepLeafL h 1 k c l).1 = 1 then some (kstepLeafL h 1 k c l).2 else none := by
  have hnb := B_botStr_length_le (c := c) hl
  simp only [kstep, kstepLeafL, laneRepL_one, land_eq', lor_eq', xor_eq', shiftRight_eq', shiftLeft_eq', add_eq',
    sub_eq', mul_eq', pow_eq', lengthF_eq, ofLF_eq]
  have hX : revLanesL 1 h ((k >>> (3 * h)) &&& (2 ^ h - 1)) = revBits h (fieldX h k) 0 := B_field_eq (by omega) _
  have hY : revLanesL 1 h ((k >>> (2 * h)) &&& (2 ^ h - 1)) = revBits h (fieldY h k) 0 := B_field_eq (by omega) _
  have hDX : revLanesL 1 h ((k >>> h) &&& (2 ^ h - 1)) = revBits h (fieldDX h k) 0 := B_field_eq (by omega) _
  have hDY : revLanesL 1 h (k &&& (2 ^ h - 1)) = revBits h (fieldDY h k) 0 := B_field_eq (by omega) _
  rw [hX, hY, hDX, hDY]
  have hxs := revBits_lt h (fieldX h k)
  have hys := revBits_lt h (fieldY h k)
  have hdxs := revBits_lt h (fieldDX h k)
  have hdys := revBits_lt h (fieldDY h k)
  generalize revBits h (fieldX h k) 0 = xs at hxs ⊢
  generalize revBits h (fieldY h k) 0 = ys at hys ⊢
  generalize revBits h (fieldDX h k) 0 = dxs at hdxs ⊢
  generalize revBits h (fieldDY h k) 0 = dys at hdys ⊢
  generalize topStr c l = top
  generalize botStr c l = bot at hnb ⊢
  -- region R1
  rw [B_region1L_eq xs bot dxs 0 0 0 hdxs]
  obtain ⟨hR1a, hR1b, hR1c⟩ := B_region1M_lt xs bot dxs 0 0 0 hdxs (by norm_num) (by norm_num)
  generalize region1M (h - 1) (2 ^ h - 1) xs dxs bot 0 0 0 = R1 at hR1a hR1b hR1c ⊢
  -- region R2
  have hH0 : (dys ||| (R1.2.2 <<< h)) < 2 ^ (h + bot.length) := by
    apply Nat.or_lt_two_pow
    · exact lt_of_lt_of_le hdys (Nat.pow_le_pow_right (by norm_num) (by omega))
    · rw [Nat.shiftLeft_eq, pow_add, mul_comm]
      exact Nat.mul_lt_mul_of_pos_left (by simpa using hR1c) (by positivity)
  obtain ⟨e1, e2, e3, e4, e5⟩ := B_region2_eq (β := h + bot.length) (ys ||| (ofL bot <<< h)) top
    (dys ||| (R1.2.2 <<< h)) 0 [] 0 0 0 0 hH0
  rw [e1, e2, e3, e4, e5]
  simp only [List.append_nil, Nat.zero_or, Nat.shiftLeft_zero]
  have hRSlt := B_rows_lt (β := h + bot.length) (ys ||| (ofL bot <<< h)) top _ hH0
  have hRSlen := B_rows_length (2 ^ (h + bot.length) - 1) (ys ||| (ofL bot <<< h)) top (dys ||| (R1.2.2 <<< h))
  generalize B_rows (2 ^ (h + bot.length) - 1) (ys ||| (ofL bot <<< h)) top (dys ||| (R1.2.2 <<< h)) = RS
    at hRSlt hRSlen ⊢
  generalize region2M (h + bot.length) (2 ^ (h + bot.length) - 1) (ys ||| (ofL bot <<< h)) (dys ||| (R1.2.2 <<< h))
    top 0 0 0 0 0 = R2
  -- the traceback
  have hβ1 : 1 ≤ h + bot.length := by omega
  have hβ32 : h + bot.length ≤ 32 := by omega
  have hhβ : h ≤ h + bot.length := by omega
  generalize h + bot.length = β at hβ1 hβ32 hhβ hRSlt ⊢
  rw [← B_enc_pos hβ1, B_final_fold, B_trace_kstep hh1 hhβ hβ32 R1.2.1 R1.2.2 RS hRSlt hRSlen, B_code hh1 hh]
  split_ifs <;> first | exact ⟨le_rfl, rfl⟩ | exact ⟨Nat.zero_le _, rfl⟩ | contradiction

end CS31a

