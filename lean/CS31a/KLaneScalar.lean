import CS31a.Lane

/-!
# The packed functions on one lane

With one lane (`L = 1`, masks = plain numbers) the functions of `CS31aCert.KLane` compute the quantities of `kstep`:
`fillDownL` fills below the highest set bit, `revLanesL 1 h` is `revBits h`, `lineUpdL` is `lineUpdM`.
-/

namespace CS31a

open CS31aCert

/-! ### Primitive names -/

theorem land_eq' (x y : ℕ) : Nat.land x y = x &&& y := rfl
theorem lor_eq' (x y : ℕ) : Nat.lor x y = x ||| y := rfl
theorem xor_eq' (x y : ℕ) : Nat.xor x y = x ^^^ y := rfl
theorem shiftRight_eq' (x k : ℕ) : Nat.shiftRight x k = x >>> k := rfl
theorem shiftLeft_eq' (x k : ℕ) : Nat.shiftLeft x k = x <<< k := rfl
theorem add_eq' (x y : ℕ) : Nat.add x y = x + y := rfl
theorem sub_eq' (x y : ℕ) : Nat.sub x y = x - y := rfl
theorem mul_eq' (x y : ℕ) : Nat.mul x y = x * y := rfl
theorem pow_eq' (x y : ℕ) : Nat.pow x y = x ^ y := rfl
theorem mod_eq' (x y : ℕ) : Nat.mod x y = x % y := rfl

/-! ### Filling below the highest set bit -/

theorem fillDown_stage {w d z y m : ℕ} (hm : m = 2 ^ w - 1) (hz : z < 2 ^ w)
    (hy : ∀ b, y.testBit b = true ↔ b < w ∧ ∃ i, b ≤ i ∧ i < b + d ∧ z.testBit i = true) :
    ∀ b, (y ||| ((y >>> d) &&& m)).testBit b = true ↔ b < w ∧ ∃ i, b ≤ i ∧ i < b + 2 * d ∧ z.testBit i = true := by
  intro b
  simp only [Nat.testBit_or, Nat.testBit_and, Nat.testBit_shiftRight, hm, Nat.testBit_two_pow_sub_one,
    Bool.or_eq_true, Bool.and_eq_true, decide_eq_true_eq, hy]
  constructor
  · rintro (⟨hb, i, h1, h2, h3⟩ | ⟨⟨_, i, h1, h2, h3⟩, hb⟩)
    · exact ⟨hb, i, h1, by omega, h3⟩
    · exact ⟨hb, i, by omega, by omega, h3⟩
  · rintro ⟨hb, i, h1, h2, h3⟩
    by_cases hi : i < b + d
    · exact Or.inl ⟨hb, i, h1, hi, h3⟩
    · have hiw : i < w := by
        by_contra hc; rw [testBit_false_of_lt_two_pow hz (by omega)] at h3; exact absurd h3 (by simp)
      exact Or.inr ⟨⟨by omega, i, by omega, by omega, h3⟩, hb⟩

theorem testBit_fillDownL {w z : ℕ} (hw : w ≤ 32) (hz : z < 2 ^ w) (b : ℕ) :
    (fillDownL (2 ^ w - 1) z).testBit b = true ↔ b < w ∧ ∃ i, b ≤ i ∧ z.testBit i = true := by
  have h0 : ∀ b, z.testBit b = true ↔ b < w ∧ ∃ i, b ≤ i ∧ i < b + 1 ∧ z.testBit i = true := by
    intro b; constructor
    · intro h; refine ⟨?_, b, le_rfl, by omega, h⟩
      by_contra hc; rw [testBit_false_of_lt_two_pow hz (by omega)] at h; exact absurd h (by simp)
    · rintro ⟨_, i, h1, h2, h3⟩; rwa [show b = i by omega]
  have s1 := fillDown_stage rfl hz h0
  have s2 := fillDown_stage rfl hz s1
  have s3 := fillDown_stage rfl hz s2
  have s4 := fillDown_stage rfl hz s3
  have s5 := fillDown_stage rfl hz s4
  have s6 := fillDown_stage rfl hz s5
  simp only [fillDownL, land_eq', lor_eq', shiftRight_eq']
  rw [s6 b]
  constructor
  · rintro ⟨hb, i, h1, -, h3⟩; exact ⟨hb, i, h1, h3⟩
  · rintro ⟨hb, i, h1, h3⟩
    have hiw : i < w := by
      by_contra hc; rw [testBit_false_of_lt_two_pow hz (by omega)] at h3; exact absurd h3 (by simp)
    exact ⟨hb, i, h1, by omega, h3⟩

/-- `fillDownL` sets exactly the bits up to the highest set bit. -/
theorem fillDownL_eq {w z : ℕ} (hw : w ≤ 32) (hz : z < 2 ^ w) :
    fillDownL (2 ^ w - 1) z = if z = 0 then 0 else 2 ^ (z.log2 + 1) - 1 := by
  apply Nat.eq_of_testBit_eq; intro b
  rw [Bool.eq_iff_iff, testBit_fillDownL hw hz]
  split_ifs with h0
  · subst h0; simp
  · rw [Nat.testBit_two_pow_sub_one, decide_eq_true_eq]
    have hlog : z.log2 < w := (Nat.log2_lt h0).2 hz
    constructor
    · rintro ⟨_, i, h1, h3⟩
      have : i ≤ z.log2 := by
        by_contra hc
        rw [testBit_false_of_lt_two_pow Nat.lt_log2_self (by omega)] at h3; exact absurd h3 (by simp)
      omega
    · intro hb; exact ⟨by omega, z.log2, by omega, Nat.testBit_log2 h0⟩

theorem fillDownL_lt {w z : ℕ} (hw : w ≤ 32) (hz : z < 2 ^ w) : fillDownL (2 ^ w - 1) z < 2 ^ w := by
  rw [fillDownL_eq hw hz]
  split_ifs with h0
  · positivity
  · have hlog : z.log2 < w := (Nat.log2_lt h0).2 hz
    have : 2 ^ (z.log2 + 1) ≤ 2 ^ w := Nat.pow_le_pow_right (by norm_num) (by omega)
    omega

/-! ### Copying bit 0 -/

theorem spreadL_one (fh : ℕ) : spreadL fh 1 = 4294967295 &&& fh := rfl

theorem spreadL_zero (fh : ℕ) : spreadL fh 0 = 0 := by
  simp [spreadL, land_eq', lor_eq', shiftLeft_eq']

theorem spreadL_eq {h b : ℕ} (hh : h ≤ 32) (hb : b ≤ 1) : spreadL (2 ^ h - 1) b = if b = 1 then 2 ^ h - 1 else 0 := by
  interval_cases b
  · simp [spreadL_zero]
  · rw [spreadL_one, if_pos rfl, Nat.land_comm, show (4294967295 : ℕ) = 2 ^ 32 - 1 by norm_num,
      Nat.and_two_pow_sub_one_eq_mod]
    have : 2 ^ h ≤ 2 ^ 32 := Nat.pow_le_pow_right (by norm_num) hh
    have : 1 ≤ 2 ^ h := Nat.one_le_two_pow
    exact Nat.mod_eq_of_lt (by omega)

/-! ### Bit reversal -/

/-- One stage of the reversal network: bit `b < 64` of the result is bit `b ^^^ k` of the input. -/
theorem testBit_revStage {k M : ℕ} (hA : ∀ b < 64, M.testBit b = true → b + k < 64 ∧ b ^^^ k = b + k)
    (hB : ∀ b < 64, M.testBit b = false → k ≤ b ∧ b ^^^ k = b - k ∧ M.testBit (b - k) = true)
    (hC : ∀ b < 64, M.testBit b = true → k ≤ b → M.testBit (b - k) = false)
    (hD : ∀ b, 64 ≤ b → M.testBit b = false) (hE : ∀ b < 64, 64 ≤ b + k → M.testBit b = false) (z : ℕ) :
    ∀ b, (((z >>> k) &&& M) ||| ((z &&& M) <<< k)).testBit b = (decide (b < 64) && z.testBit (b ^^^ k)) := by
  intro b
  simp only [Nat.testBit_or, Nat.testBit_and, Nat.testBit_shiftRight, Nat.testBit_shiftLeft]
  by_cases hb : b < 64
  · simp only [hb, decide_true, Bool.true_and]
    cases hM : M.testBit b
    · obtain ⟨hk, hx, hM'⟩ := hB b hb hM
      simp [hk, hx, hM']
    · obtain ⟨_, hx⟩ := hA b hb hM
      by_cases hk : k ≤ b
      · simp [hk, hx, hC b hb hM hk, Nat.add_comm k b]
      · simp [hk, hx, Nat.add_comm k b]
  · simp only [hb, decide_false, Bool.false_and, hD b (by omega), Bool.and_false, Bool.false_or]
    by_cases hk : k ≤ b
    · by_cases hbk : b - k < 64
      · simp [hE (b - k) hbk (by omega)]
      · simp [hD (b - k) (by omega)]
    · simp [hk]

/-- The 64-bit reversal network of `revLanesL` on one lane. -/
def rev64 (x : ℕ) : ℕ :=
  let x := ((x >>> 1) &&& 0x5555555555555555) ||| ((x &&& 0x5555555555555555) <<< 1)
  let x := ((x >>> 2) &&& 0x3333333333333333) ||| ((x &&& 0x3333333333333333) <<< 2)
  let x := ((x >>> 4) &&& 0x0F0F0F0F0F0F0F0F) ||| ((x &&& 0x0F0F0F0F0F0F0F0F) <<< 4)
  let x := ((x >>> 8) &&& 0x00FF00FF00FF00FF) ||| ((x &&& 0x00FF00FF00FF00FF) <<< 8)
  let x := ((x >>> 16) &&& 0x0000FFFF0000FFFF) ||| ((x &&& 0x0000FFFF0000FFFF) <<< 16)
  ((x >>> 32) &&& 0x00000000FFFFFFFF) ||| ((x &&& 0x00000000FFFFFFFF) <<< 32)

set_option maxRecDepth 4000 in
theorem testBit_rev64 (z b : ℕ) : (rev64 z).testBit b = (decide (b < 64) && z.testBit (63 - b)) := by
  have s1 := testBit_revStage (k := 1) (M := 0x5555555555555555) (by decide) (by decide) (by decide)
    (fun b hb => testBit_false_of_lt_two_pow (by norm_num : (0x5555555555555555 : ℕ) < 2 ^ 64) hb) (by decide)
  have s2 := testBit_revStage (k := 2) (M := 0x3333333333333333) (by decide) (by decide) (by decide)
    (fun b hb => testBit_false_of_lt_two_pow (by norm_num : (0x3333333333333333 : ℕ) < 2 ^ 64) hb) (by decide)
  have s4 := testBit_revStage (k := 4) (M := 0x0F0F0F0F0F0F0F0F) (by decide) (by decide) (by decide)
    (fun b hb => testBit_false_of_lt_two_pow (by norm_num : (0x0F0F0F0F0F0F0F0F : ℕ) < 2 ^ 64) hb) (by decide)
  have s8 := testBit_revStage (k := 8) (M := 0x00FF00FF00FF00FF) (by decide) (by decide) (by decide)
    (fun b hb => testBit_false_of_lt_two_pow (by norm_num : (0x00FF00FF00FF00FF : ℕ) < 2 ^ 64) hb) (by decide)
  have s16 := testBit_revStage (k := 16) (M := 0x0000FFFF0000FFFF) (by decide) (by decide) (by decide)
    (fun b hb => testBit_false_of_lt_two_pow (by norm_num : (0x0000FFFF0000FFFF : ℕ) < 2 ^ 64) hb) (by decide)
  have s32 := testBit_revStage (k := 32) (M := 0x00000000FFFFFFFF) (by decide) (by decide) (by decide)
    (fun b hb => testBit_false_of_lt_two_pow (by norm_num : (0x00000000FFFFFFFF : ℕ) < 2 ^ 64) hb) (by decide)
  simp only [rev64]
  rw [s32, s16, s8, s4, s2, s1]
  by_cases hb : b < 64
  · have key : ∀ b < 64, (((((b ^^^ 32 ^^^ 16) ^^^ 8) ^^^ 4) ^^^ 2) ^^^ 1) = 63 - b ∧
        b ^^^ 32 < 64 ∧ b ^^^ 32 ^^^ 16 < 64 ∧ (b ^^^ 32 ^^^ 16) ^^^ 8 < 64 ∧ ((b ^^^ 32 ^^^ 16) ^^^ 8) ^^^ 4 < 64 ∧
        (((b ^^^ 32 ^^^ 16) ^^^ 8) ^^^ 4) ^^^ 2 < 64 := by decide
    obtain ⟨k1, k2, k3, k4, k5, k6⟩ := key b hb
    simp [hb, k1, k2, k3, k4, k5, k6]
  · simp [hb]

theorem laneRepL_one (v : ℕ) : laneRepL v 1 = v := by
  simp [laneRepL, lor_eq', shiftLeft_eq']

theorem revLanesL_one (h z : ℕ) : revLanesL 1 h z = (rev64 z >>> (64 - h)) &&& (2 ^ h - 1) := by
  simp only [revLanesL, laneRepL_one, land_eq', lor_eq', shiftRight_eq', shiftLeft_eq', sub_eq', pow_eq', rev64]

theorem testBit_revBits (h z b : ℕ) : (revBits h z 0).testBit b = (decide (b < h) && z.testBit (h - 1 - b)) := by
  rw [revBits_eq_ofL, testBit_ofL]
  by_cases hb : b < h
  · rw [getD_bitsMSB z h b hb]; simp [hb]
  · rw [getD_eq_false_of_le (by rw [bitsMSB_length]; omega)]; simp [hb]

/-- `revLanesL` on one lane is `revBits`. -/
theorem revLanesL_one_eq {h : ℕ} (hh : h ≤ 64) (z : ℕ) : revLanesL 1 h z = revBits h z 0 := by
  rw [revLanesL_one]
  apply Nat.eq_of_testBit_eq; intro b
  rw [Nat.testBit_and, Nat.testBit_shiftRight, testBit_rev64, Nat.testBit_two_pow_sub_one, testBit_revBits]
  by_cases hb : b < h
  · simp [hb, show 64 - h + b < 64 by omega, show 63 - (64 - h + b) = h - 1 - b by omega]
  · simp [hb]

theorem revBits_lt (h z : ℕ) : revBits h z 0 < 2 ^ h := by
  rw [revBits_eq_ofL]
  have := ofL_lt (bitsMSB z h)
  rwa [bitsMSB_length] at this

/-! ### Line update -/

theorem lineUpd_cr_lt {w inc : ℕ} (hinc : inc < 2 ^ w) (m : ℕ) :
    (((inc ^^^ (2 ^ w - 1)) + ((inc ^^^ (2 ^ w - 1)) &&& m)) ^^^
      ((inc ^^^ (2 ^ w - 1)) ^^^ ((inc ^^^ (2 ^ w - 1)) &&& m))) >>> 1 < 2 ^ w := by
  have ht : inc ^^^ (2 ^ w - 1) < 2 ^ w := Nat.xor_lt_two_pow hinc (by omega)
  have hg : (inc ^^^ (2 ^ w - 1)) &&& m ≤ inc ^^^ (2 ^ w - 1) := Nat.and_le_left
  have h1 : (inc ^^^ (2 ^ w - 1)) + ((inc ^^^ (2 ^ w - 1)) &&& m) < 2 ^ (w + 1) := by rw [Nat.pow_succ]; omega
  have h2 : (inc ^^^ (2 ^ w - 1)) ^^^ ((inc ^^^ (2 ^ w - 1)) &&& m) < 2 ^ (w + 1) :=
    Nat.xor_lt_two_pow (by rw [Nat.pow_succ]; omega) (by rw [Nat.pow_succ]; omega)
  have h3 := Nat.xor_lt_two_pow h1 h2
  rw [Nat.shiftRight_eq_div_pow, Nat.pow_one]
  rw [Nat.pow_succ] at h3
  omega

/-- On one lane, `lineUpdL` is `lineUpdM` (the extra mask on the cross increments is redundant). -/
theorem lineUpdL_one {w inc : ℕ} (hinc : inc < 2 ^ w) (m : ℕ) :
    lineUpdL (2 ^ w - 1) m inc = lineUpdM (2 ^ w - 1) true m inc := by
  simp only [lineUpdL, lineUpdM, land_eq', lor_eq', xor_eq', shiftRight_eq', shiftLeft_eq', add_eq', ite_true]
  rw [Nat.and_two_pow_sub_one_eq_mod _ w, Nat.mod_eq_of_lt (lineUpd_cr_lt hinc m)]

theorem lineUpdM_sym (w : ℕ) (b : Bool) (xs inc : ℕ) :
    lineUpdM (2 ^ w - 1) true (Bool.rec (motive := fun _ => ℕ) (Nat.xor xs (2 ^ w - 1)) xs b) inc =
      lineUpdM (2 ^ w - 1) b xs inc := by
  cases b <;> rfl

theorem lineUpdM_snd_lt {w inc : ℕ} (hinc : inc < 2 ^ w) (sym : Bool) (m : ℕ) :
    (lineUpdM (2 ^ w - 1) sym m inc).2 < 2 ^ w :=
  lineUpd_cr_lt hinc _

theorem lineUpdM_fst_lt {w inc : ℕ} (hinc : inc < 2 ^ w) (sym : Bool) (m : ℕ) :
    (lineUpdM (2 ^ w - 1) sym m inc).1 < 2 ^ w := by
  have hcr := lineUpdM_snd_lt hinc sym m
  simp only [lineUpdM] at hcr ⊢
  exact Nat.or_lt_two_pow (lt_of_le_of_lt Nat.and_le_right hcr) (lt_of_le_of_lt Nat.and_le_left hinc)

end CS31a
