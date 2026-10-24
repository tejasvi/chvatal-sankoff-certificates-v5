import CS31a.KStepEq
import CS31aCert.KLane

/-!
# Lanes of packed numbers

Lane `j` of `x` is `(x >>> 64 j) % 2^64`. Bitwise operations act lane by lane; a right shift followed by a mask whose
lanes are below `2^(64 - k)` and a left shift of lanes below `2^(64 - k)` stay inside the lanes; an addition without
carry out of the lanes `0 … j` adds lane `j`.
-/

namespace CS31a

open CS31aCert

/-- Lane `j` (bits `64 j … 64 j + 63`) of a packed number. -/
def lane (j x : ℕ) : ℕ := (x >>> (64 * j)) % 2 ^ 64

theorem testBit_lane (j x b : ℕ) : (lane j x).testBit b = (decide (b < 64) && x.testBit (64 * j + b)) := by
  unfold lane; rw [Nat.testBit_mod_two_pow, Nat.testBit_shiftRight]

theorem lane_lt (j x : ℕ) : lane j x < 2 ^ 64 := Nat.mod_lt _ (by positivity)

theorem testBit_lane_ge {j x b : ℕ} (hb : 64 ≤ b) : (lane j x).testBit b = false := by
  simp [testBit_lane, show ¬b < 64 by omega]

/-- Two numbers below `2^64` are equal if their bits below `64` are. -/
theorem eq_of_testBit_lt64 {a b : ℕ} (ha : a < 2 ^ 64) (hb : b < 2 ^ 64) (h : ∀ i < 64, a.testBit i = b.testBit i) :
    a = b := by
  apply Nat.eq_of_testBit_eq; intro i
  by_cases hi : i < 64
  · exact h i hi
  · rw [Nat.testBit_lt_two_pow (lt_of_lt_of_le ha (Nat.pow_le_pow_right (by norm_num) (by omega))),
      Nat.testBit_lt_two_pow (lt_of_lt_of_le hb (Nat.pow_le_pow_right (by norm_num) (by omega)))]

theorem testBit_false_of_lt_two_pow {a w i : ℕ} (ha : a < 2 ^ w) (hi : w ≤ i) : a.testBit i = false :=
  Nat.testBit_lt_two_pow (lt_of_lt_of_le ha (Nat.pow_le_pow_right (by norm_num) hi))

theorem lane_land (j x y : ℕ) : lane j (x &&& y) = lane j x &&& lane j y := by
  apply Nat.eq_of_testBit_eq; intro b
  simp only [testBit_lane, Nat.testBit_and]; cases decide (b < 64) <;> simp

theorem lane_lor (j x y : ℕ) : lane j (x ||| y) = lane j x ||| lane j y := by
  apply Nat.eq_of_testBit_eq; intro b
  simp only [testBit_lane, Nat.testBit_or]; cases decide (b < 64) <;> simp

theorem lane_xor (j x y : ℕ) : lane j (x ^^^ y) = lane j x ^^^ lane j y := by
  apply Nat.eq_of_testBit_eq; intro b
  simp only [testBit_lane, Nat.testBit_xor]; cases decide (b < 64) <;> simp

theorem lane_of_lt {x : ℕ} (hx : x < 2 ^ 64) : lane 0 x = x := by
  unfold lane; rw [Nat.mul_zero, Nat.shiftRight_zero, Nat.mod_eq_of_lt hx]

theorem lane_succ_of_lt {x : ℕ} (j : ℕ) (hx : x < 2 ^ 64) : lane (j + 1) x = 0 := by
  apply Nat.eq_of_testBit_eq; intro b
  simp only [testBit_lane, Nat.zero_testBit]
  rw [testBit_false_of_lt_two_pow hx (by omega)]; simp

theorem lane_shiftLeft64 (j y : ℕ) : lane (j + 1) (y <<< 64) = lane j y := by
  apply Nat.eq_of_testBit_eq; intro b
  simp only [testBit_lane, Nat.testBit_shiftLeft]
  by_cases hb : b < 64
  · simp [hb, show 64 * (j + 1) + b ≥ 64 by omega, show 64 * (j + 1) + b - 64 = 64 * j + b by omega]
  · simp [hb]

theorem lane_zero_shiftLeft64 (y : ℕ) : lane 0 (y <<< 64) = 0 := by
  apply Nat.eq_of_testBit_eq; intro b
  simp only [testBit_lane, Nat.testBit_shiftLeft, Nat.zero_testBit]
  by_cases hb : b < 64 <;> simp [hb]

theorem laneRepL_succ (v L : ℕ) : laneRepL v (L + 1) = v ||| (laneRepL v L <<< 64) := rfl

theorem lane_laneRepL {v : ℕ} (hv : v < 2 ^ 64) : ∀ L j, lane j (laneRepL v L) = if j < L then v else 0
  | 0, j => by simp [laneRepL, lane]
  | L + 1, 0 => by
    rw [laneRepL_succ, lane_lor, lane_of_lt hv, lane_zero_shiftLeft64]; simp
  | L + 1, j + 1 => by
    rw [laneRepL_succ, lane_lor, lane_succ_of_lt j hv, lane_shiftLeft64, lane_laneRepL hv L j]
    simp

/-- A right shift followed by a mask whose lane is below `2^(64 - k)` stays inside the lane. -/
theorem lane_shiftRight_land {k : ℕ} (j x M : ℕ) (hM : lane j M < 2 ^ (64 - k)) :
    lane j ((x >>> k) &&& M) = (lane j x >>> k) &&& lane j M := by
  apply Nat.eq_of_testBit_eq; intro b
  simp only [testBit_lane, Nat.testBit_and, Nat.testBit_shiftRight]
  by_cases hb : b < 64
  · by_cases hbk : k + b < 64
    · simp [hb, hbk, show 64 * j + (k + b) = k + (64 * j + b) by omega]
    · have := testBit_false_of_lt_two_pow hM (show 64 - k ≤ b by omega)
      simp only [testBit_lane, hb, decide_true, Bool.true_and] at this
      simp [hb, this]
  · simp [hb]

/-- A left shift of a lane below `2^(64 - k)` (whose lower neighbour is also below `2^(64 - k)`) stays inside. -/
theorem lane_shiftLeft {k : ℕ} (j x : ℕ) (hk : k ≤ 64) (hlo : j = 0 ∨ lane (j - 1) x < 2 ^ (64 - k))
    (hx : lane j x < 2 ^ (64 - k)) : lane j (x <<< k) = lane j x <<< k := by
  have hlt : lane j x <<< k < 2 ^ 64 := by
    rw [Nat.shiftLeft_eq]
    calc lane j x * 2 ^ k < 2 ^ (64 - k) * 2 ^ k := Nat.mul_lt_mul_of_pos_right hx (by positivity)
      _ = 2 ^ 64 := by rw [← Nat.pow_add]; congr 1; omega
  apply eq_of_testBit_lt64 (lane_lt _ _) hlt
  intro b hb
  simp only [testBit_lane, Nat.testBit_shiftLeft, hb, decide_true, Bool.true_and]
  by_cases hbk : k ≤ b
  · simp [hbk, show 64 * j + b ≥ k by omega, show 64 * j + b - k = 64 * j + (b - k) by omega,
      show b - k < 64 by omega]
  · simp only [show ¬(b ≥ k) by omega, decide_false, Bool.false_and]
    rcases hlo with h0 | hlo
    · subst h0; simp [show ¬(b ≥ k) by omega]
    · by_cases hjk : 64 * j + b ≥ k
      · have := testBit_false_of_lt_two_pow hlo (show 64 - k ≤ 64 + b - k by omega)
        simp only [testBit_lane, show 64 + b - k < 64 ↔ b < k by omega, show b < k by omega, decide_true,
          Bool.true_and] at this
        rw [show 64 * (j - 1) + (64 + b - k) = 64 * j + b - k by
          rcases Nat.eq_zero_or_pos j with hj | hj
          · subst hj; omega
          · rw [Nat.mul_sub, Nat.mul_one]; omega] at this
        simp [hjk, this]
      · simp [hjk]

/-- The low `64 j` bits of `x` and lane `j`. -/
theorem mod_pow_succ_lane (j x : ℕ) : x % 2 ^ (64 * (j + 1)) = x % 2 ^ (64 * j) + 2 ^ (64 * j) * lane j x := by
  rw [show 64 * (j + 1) = 64 * j + 64 by ring, Nat.pow_add, Nat.mod_mul, lane, Nat.shiftRight_eq_div_pow]

theorem low_add_lt {x y : ℕ} : ∀ j, (∀ i < j, lane i x + lane i y < 2 ^ 64) →
    x % 2 ^ (64 * j) + y % 2 ^ (64 * j) < 2 ^ (64 * j)
  | 0, _ => by simp [Nat.mod_one]
  | j + 1, h => by
    have ih := low_add_lt j (fun i hi => h i (by omega))
    have hj := h j (by omega)
    rw [mod_pow_succ_lane, mod_pow_succ_lane]
    calc x % 2 ^ (64 * j) + 2 ^ (64 * j) * lane j x + (y % 2 ^ (64 * j) + 2 ^ (64 * j) * lane j y)
        = (x % 2 ^ (64 * j) + y % 2 ^ (64 * j)) + 2 ^ (64 * j) * (lane j x + lane j y) := by ring
      _ < 2 ^ (64 * j) + 2 ^ (64 * j) * (lane j x + lane j y) := by omega
      _ ≤ 2 ^ (64 * j) + 2 ^ (64 * j) * (2 ^ 64 - 1) := by
          have : lane j x + lane j y ≤ 2 ^ 64 - 1 := by omega
          exact Nat.add_le_add_left (Nat.mul_le_mul_left _ this) _
      _ = 2 ^ (64 * (j + 1)) := by
          rw [show 64 * (j + 1) = 64 * j + 64 by ring, Nat.pow_add]
          have : 1 ≤ 2 ^ 64 := Nat.one_le_two_pow
          rw [Nat.mul_sub, Nat.mul_one]
          have : 2 ^ (64 * j) ≤ 2 ^ (64 * j) * 2 ^ 64 := Nat.le_mul_of_pos_right _ (by positivity)
          omega

/-- An addition without carry out of the lanes `0 … j` adds lane `j`. -/
theorem lane_add {x y : ℕ} (j : ℕ) (h : ∀ i ≤ j, lane i x + lane i y < 2 ^ 64) :
    lane j (x + y) = lane j x + lane j y := by
  have hlow := low_add_lt (x := x) (y := y) j (fun i hi => h i (by omega))
  have hx := Nat.mod_add_div x (2 ^ (64 * j))
  have hy := Nat.mod_add_div y (2 ^ (64 * j))
  have hsum : (x + y) / 2 ^ (64 * j) = x / 2 ^ (64 * j) + y / 2 ^ (64 * j) := by
    have : x + y = (x % 2 ^ (64 * j) + y % 2 ^ (64 * j)) + 2 ^ (64 * j) * (x / 2 ^ (64 * j) + y / 2 ^ (64 * j)) := by
      linarith
    rw [this, Nat.add_mul_div_left _ _ (by positivity), Nat.div_eq_of_lt hlow, Nat.zero_add]
  simp only [lane, Nat.shiftRight_eq_div_pow] at h ⊢
  rw [hsum, Nat.add_mod]
  exact Nat.mod_eq_of_lt (by have := h j le_rfl; simpa using this)

end CS31a
