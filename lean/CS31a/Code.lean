import CS31a.Defs
import CS31aCert.Step

/-!
# Codes of states: `encode`, `decode` and their basic properties
-/

namespace CS31a

open CS31aCert

/-! ### `ofBitsMSB` and `bitsMSB` -/

theorem ofBitsMSB_acc (l : List Bool) (acc : ℕ) : ofBitsMSB l acc = acc * 2 ^ l.length + ofBitsMSB l 0 := by
  induction l generalizing acc with
  | nil => simp [ofBitsMSB]
  | cons b bs ih =>
    simp only [ofBitsMSB, List.length_cons]
    rw [ih, ih (2 * 0 + _)]
    cases b <;> simp [pow_succ] <;> ring

theorem ofBitsMSB_cons (b : Bool) (bs : List Bool) :
    ofBitsMSB (b :: bs) 0 = (if b then 2 ^ bs.length else 0) + ofBitsMSB bs 0 := by
  rw [ofBitsMSB, ofBitsMSB_acc]; cases b <;> simp

theorem ofBitsMSB_lt (l : List Bool) : ofBitsMSB l 0 < 2 ^ l.length := by
  induction l with
  | nil => simp [ofBitsMSB]
  | cons b bs ih =>
    rw [ofBitsMSB_cons, List.length_cons, pow_succ]
    cases b <;> simp <;> omega

theorem testBit_ofBitsMSB (l : List Bool) (i : ℕ) :
    (ofBitsMSB l 0).testBit i = if i < l.length then l.getD (l.length - 1 - i) false else false := by
  induction l generalizing i with
  | nil => simp [ofBitsMSB]
  | cons b bs ih =>
    rw [ofBitsMSB_cons, List.length_cons]
    have hlt := ofBitsMSB_lt bs
    by_cases hi : i < bs.length
    · have hne : ¬ i = bs.length := by omega
      cases b
      · simp only [Bool.false_eq_true, if_false, zero_add]
        rw [ih, if_pos hi, if_pos (by omega)]
        rw [show bs.length + 1 - 1 - i = (bs.length - 1 - i) + 1 by omega]
        simp
      · simp only [if_true]
        rw [Nat.testBit_two_pow_add_gt hi, ih, if_pos hi, if_pos (by omega)]
        rw [show bs.length + 1 - 1 - i = (bs.length - 1 - i) + 1 by omega]
        simp
    · by_cases he : i = bs.length
      · subst he
        cases b
        · simp only [Bool.false_eq_true, if_false, zero_add]
          rw [Nat.testBit_eq_false_of_lt hlt]
          simp
        · simp only [if_true]
          rw [Nat.testBit_two_pow_add_eq, Nat.testBit_eq_false_of_lt hlt]
          simp
      · have hgt : bs.length < i := by omega
        have hlt2 : (if b then 2 ^ bs.length else 0) + ofBitsMSB bs 0 < 2 ^ i := by
          have : 2 ^ (bs.length + 1) ≤ 2 ^ i := Nat.pow_le_pow_right (by norm_num) hgt
          rw [pow_succ] at this
          cases b <;> simp <;> omega
        rw [Nat.testBit_eq_false_of_lt hlt2, if_neg (by omega)]

theorem bitsMSB_length (n k : ℕ) : (bitsMSB n k).length = k := by
  induction k with
  | zero => rfl
  | succ k ih => simp [bitsMSB, ih]

theorem getD_bitsMSB (n k j : ℕ) (hj : j < k) : (bitsMSB n k).getD j false = n.testBit (k - 1 - j) := by
  induction k generalizing j with
  | zero => omega
  | succ k ih =>
    cases j with
    | zero => simp [bitsMSB]
    | succ j =>
      simp only [bitsMSB, List.getD_cons_succ]
      rw [ih j (by omega)]
      congr 1; omega

theorem bitsMSB_ofBitsMSB (l : List Bool) : bitsMSB (ofBitsMSB l 0) l.length = l := by
  apply List.ext_getElem (by rw [bitsMSB_length])
  intro j h1 h2
  have := getD_bitsMSB (ofBitsMSB l 0) l.length j h2
  rw [List.getD_eq_getElem _ _ h1] at this
  rw [this, testBit_ofBitsMSB, if_pos (by omega)]
  rw [List.getD_eq_getElem _ _ (by omega)]
  congr 1; omega

theorem ofBitsMSB_bitsMSB (n k : ℕ) (hn : n < 2 ^ k) : ofBitsMSB (bitsMSB n k) 0 = n := by
  apply Nat.eq_of_testBit_eq
  intro i
  rw [testBit_ofBitsMSB, bitsMSB_length]
  by_cases hi : i < k
  · rw [if_pos hi, getD_bitsMSB _ _ _ (by omega)]
    congr 1; omega
  · rw [if_neg hi, Nat.testBit_eq_false_of_lt (lt_of_lt_of_le hn (Nat.pow_le_pow_right (by norm_num) (by omega)))]

/-! ### Packing four fields -/

theorem packCode_lt (h x y dx dy : ℕ) (hx : x < 2 ^ h) (hy : y < 2 ^ h) (hdx : dx < 2 ^ h) (hdy : dy < 2 ^ h) :
    packCode h x y dx dy < 2 ^ (4 * h) := by
  unfold packCode
  have e : 2 ^ (4 * h) = 2 ^ h * 2 ^ h * 2 ^ h * 2 ^ h := by rw [← pow_add, ← pow_add, ← pow_add]; ring_nf
  rw [e]
  have h1 : x * 2 ^ h + y < 2 ^ h * 2 ^ h := by nlinarith
  have h2 : (x * 2 ^ h + y) * 2 ^ h + dx < 2 ^ h * 2 ^ h * 2 ^ h := by nlinarith
  nlinarith

theorem div_pack (a b B : ℕ) (hb : b < B) : (a * B + b) / B = a := by
  have hB : 0 < B := lt_of_le_of_lt (Nat.zero_le _) hb
  rw [add_comm, Nat.add_mul_div_right _ _ hB, Nat.div_eq_of_lt hb, zero_add]

theorem mod_pack (a b B : ℕ) (hb : b < B) : (a * B + b) % B = b := by
  rw [add_comm, Nat.add_mul_mod_self_right, Nat.mod_eq_of_lt hb]

theorem shiftRight_h (h k : ℕ) : k >>> h = k / 2 ^ h := Nat.shiftRight_eq_div_pow _ _

theorem shiftRight_2h (h k : ℕ) : k >>> (2 * h) = k / 2 ^ h / 2 ^ h := by
  rw [Nat.shiftRight_eq_div_pow, Nat.div_div_eq_div_mul, ← pow_add, two_mul]

theorem shiftRight_3h (h k : ℕ) : k >>> (3 * h) = k / 2 ^ h / 2 ^ h / 2 ^ h := by
  rw [Nat.shiftRight_eq_div_pow, Nat.div_div_eq_div_mul, Nat.div_div_eq_div_mul, ← pow_add, ← pow_add]
  ring_nf

theorem fieldDY_packCode (h x y dx dy : ℕ) (hdy : dy < 2 ^ h) : fieldDY h (packCode h x y dx dy) = dy := by
  unfold fieldDY packCode; exact mod_pack _ _ _ hdy

theorem fieldDX_packCode (h x y dx dy : ℕ) (hdx : dx < 2 ^ h) (hdy : dy < 2 ^ h) :
    fieldDX h (packCode h x y dx dy) = dx := by
  unfold fieldDX packCode; rw [shiftRight_h, div_pack _ _ _ hdy, mod_pack _ _ _ hdx]

theorem fieldY_packCode (h x y dx dy : ℕ) (hy : y < 2 ^ h) (hdx : dx < 2 ^ h) (hdy : dy < 2 ^ h) :
    fieldY h (packCode h x y dx dy) = y := by
  unfold fieldY packCode; rw [shiftRight_2h, div_pack _ _ _ hdy, div_pack _ _ _ hdx, mod_pack _ _ _ hy]

theorem fieldX_packCode (h x y dx dy : ℕ) (hx : x < 2 ^ h) (hy : y < 2 ^ h) (hdx : dx < 2 ^ h)
    (hdy : dy < 2 ^ h) : fieldX h (packCode h x y dx dy) = x := by
  unfold fieldX packCode
  rw [shiftRight_3h, div_pack _ _ _ hdy, div_pack _ _ _ hdx, div_pack _ _ _ hy, Nat.mod_eq_of_lt hx]

theorem fields_lt (h k : ℕ) : fieldX h k < 2 ^ h ∧ fieldY h k < 2 ^ h ∧ fieldDX h k < 2 ^ h ∧ fieldDY h k < 2 ^ h :=
  ⟨Nat.mod_lt _ (by positivity), Nat.mod_lt _ (by positivity), Nat.mod_lt _ (by positivity),
    Nat.mod_lt _ (by positivity)⟩

theorem packCode_fields (h k : ℕ) (hk : k < 2 ^ (4 * h)) :
    packCode h (fieldX h k) (fieldY h k) (fieldDX h k) (fieldDY h k) = k := by
  unfold packCode fieldX fieldY fieldDX fieldDY
  rw [shiftRight_3h, shiftRight_2h, shiftRight_h]
  set B := 2 ^ h with hB
  have e4 : 2 ^ (4 * h) = B * B * B * B := by rw [hB, ← pow_add, ← pow_add, ← pow_add]; ring_nf
  rw [e4] at hk
  have hBpos : 0 < B := by positivity
  have h3 : k / B / B / B < B := by
    rw [Nat.div_div_eq_div_mul, Nat.div_div_eq_div_mul, Nat.div_lt_iff_lt_mul (by positivity)]
    calc k < B * B * B * B := hk
      _ = _ := by ring
  rw [Nat.mod_eq_of_lt h3, Nat.div_add_mod' (k / B / B) B, Nat.div_add_mod' (k / B) B, Nat.div_add_mod' k B]

/-! ### Encoding and decoding states -/

/-- The `h`-bit number of a bit string (position `t+1` = bit `h-1-t`). -/
def encF {h : ℕ} (f : Fin h → Bool) : ℕ := ofBitsMSB (List.ofFn f) 0

/-- The code of a state. -/
def encode {h : ℕ} (q : State h) : ℕ := packCode h (encF q.x) (encF q.y) (encF q.dx) (encF q.dy)

/-- The bit string of an `h`-bit field. -/
def decF (h n : ℕ) : Fin h → Bool := fun t => n.testBit (h - 1 - t.val)

/-- The state of a code. -/
def decode (h k : ℕ) : State h :=
  ⟨decF h (fieldX h k), decF h (fieldY h k), decF h (fieldDX h k), decF h (fieldDY h k)⟩

theorem encF_lt {h : ℕ} (f : Fin h → Bool) : encF f < 2 ^ h := by
  have := ofBitsMSB_lt (List.ofFn f); rwa [List.length_ofFn] at this

theorem encode_lt {h : ℕ} (q : State h) : encode q < 2 ^ (4 * h) :=
  packCode_lt _ _ _ _ _ (encF_lt _) (encF_lt _) (encF_lt _) (encF_lt _)

theorem ofFn_decF (h n : ℕ) : List.ofFn (decF h n) = bitsMSB n h := by
  apply List.ext_getElem (by simp [bitsMSB_length])
  intro j h1 h2
  simp only [List.getElem_ofFn, decF]
  rw [bitsMSB_length] at h2
  have := getD_bitsMSB n h j h2
  rw [List.getD_eq_getElem _ _ (by rw [bitsMSB_length]; exact h2)] at this
  rw [this]

theorem decF_encF {h : ℕ} (f : Fin h → Bool) : decF h (encF f) = f := by
  funext t
  simp only [decF, encF]
  rw [testBit_ofBitsMSB, List.length_ofFn, if_pos (by omega), List.getD_eq_getElem _ _ (by simp; omega)]
  simp only [List.getElem_ofFn]
  congr 1; ext; simp; omega

theorem encF_decF (h n : ℕ) (hn : n < 2 ^ h) : encF (decF h n) = n := by
  unfold encF; rw [ofFn_decF, ofBitsMSB_bitsMSB _ _ hn]

theorem decode_encode {h : ℕ} (q : State h) : decode h (encode q) = q := by
  have hx := encF_lt q.x; have hy := encF_lt q.y; have hdx := encF_lt q.dx; have hdy := encF_lt q.dy
  simp only [decode, encode, fieldX_packCode _ _ _ _ _ hx hy hdx hdy, fieldY_packCode _ _ _ _ _ hy hdx hdy,
    fieldDX_packCode _ _ _ _ _ hdx hdy, fieldDY_packCode _ _ _ _ _ hdy, decF_encF]

theorem encode_decode (h k : ℕ) (hk : k < 2 ^ (4 * h)) : encode (decode h k) = k := by
  obtain ⟨h1, h2, h3, h4⟩ := fields_lt h k
  simp only [encode, decode, encF_decF _ _ h1, encF_decF _ _ h2, encF_decF _ _ h3, encF_decF _ _ h4]
  exact packCode_fields h k hk

theorem encode_injective (h : ℕ) : Function.Injective (@encode h) := fun a b hab => by
  rw [← decode_encode a, ← decode_encode b, hab]

end CS31a
