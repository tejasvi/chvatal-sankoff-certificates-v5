import CS31a.CheckK
import CS31aCert.KStep

/-!
# `kstep = stepCode`

The mask transition `kstep` (CS31aCert/KStep.lean) computes the same function as the list transition `stepCode`.
Masks are related to lists by `ofL` (head = bit 0); every mask identity is proved bit by bit (`Nat.testBit`), except
the carry chain of a line update, which is an induction on the lists.
-/

namespace CS31a

open CS31aCert

/-! ### Masks of bit lists -/

theorem ofL_cons (b : Bool) (L : List Bool) : ofL (b :: L) = (if b then 1 else 0) + 2 * ofL L := rfl

theorem testBit_bit_add (b : Bool) (x : ℕ) :
    ((if b then 1 else 0) + 2 * x).testBit 0 = b := by
  rw [Nat.testBit_zero]; cases b <;> simp

theorem testBit_bit_add_succ (b : Bool) (x i : ℕ) :
    ((if b then 1 else 0) + 2 * x).testBit (i + 1) = x.testBit i := by
  rw [Nat.testBit_add_one]; congr 1; cases b <;> simp <;> omega

theorem testBit_ofL : ∀ (L : List Bool) (i : ℕ), (ofL L).testBit i = L.getD i false
  | [], i => by simp [ofL]
  | b :: L, 0 => by rw [ofL_cons, testBit_bit_add]; simp
  | b :: L, i + 1 => by rw [ofL_cons, testBit_bit_add_succ, testBit_ofL L i]; simp

theorem ofL_lt : ∀ L : List Bool, ofL L < 2 ^ L.length
  | [] => by simp [ofL]
  | b :: L => by
    have := ofL_lt L
    rw [ofL_cons, List.length_cons, pow_succ]; cases b <;> simp <;> omega

theorem getD_eq_false_of_le {L : List Bool} {i : ℕ} (h : L.length ≤ i) : L.getD i false = false := by
  simp [List.getD_eq_getElem?_getD, List.getElem?_eq_none h]

theorem ofL_append (L M : List Bool) : ofL (L ++ M) = ofL L ||| (ofL M <<< L.length) := by
  apply Nat.eq_of_testBit_eq; intro i
  simp only [testBit_ofL, Nat.testBit_or, Nat.testBit_shiftLeft, List.getD_eq_getElem?_getD]
  by_cases hi : i < L.length
  · rw [List.getElem?_append_left hi]; simp [show ¬(i ≥ L.length) by omega]
  · rw [List.getElem?_append_right (by omega), List.getElem?_eq_none (by omega : L.length ≤ i)]
    simp [show i ≥ L.length by omega]

theorem ofL_drop (L : List Bool) (m : ℕ) : ofL (L.drop m) = ofL L >>> m := by
  apply Nat.eq_of_testBit_eq; intro i
  simp only [testBit_ofL, Nat.testBit_shiftRight, List.getD_eq_getElem?_getD, List.getElem?_drop]

theorem ofL_map_not (L : List Bool) : ofL (L.map (!·)) = ofL L ^^^ (2 ^ L.length - 1) := by
  apply Nat.eq_of_testBit_eq; intro i
  simp only [testBit_ofL, Nat.testBit_xor, Nat.testBit_two_pow_sub_one]
  by_cases hi : i < L.length
  · simp [List.getD_eq_getElem?_getD, hi]
  · rw [getD_eq_false_of_le (by simpa using hi), getD_eq_false_of_le (by omega)]; simp [hi]

theorem ofL_mod_two (L : List Bool) : ofL L % 2 = if L.headD false then 1 else 0 := by
  cases L with
  | nil => simp [ofL]
  | cons b L => rw [ofL_cons]; cases b <;> simp <;> omega

theorem ofL_replicate_false (n : ℕ) : ofL (List.replicate n false) = 0 := by
  induction n with
  | zero => rfl
  | succ n ih => rw [List.replicate_succ, ofL_cons, ih]; simp

/-! ### A line update as one carry chain -/

theorem xor_bit (a b : Bool) (x y : ℕ) :
    ((if a then 1 else 0) + 2 * x) ^^^ ((if b then 1 else 0) + 2 * y) = (if (a ^^ b) then 1 else 0) + 2 * (x ^^^ y) := by
  apply Nat.eq_of_testBit_eq; intro i
  cases i with
  | zero => simp only [Nat.testBit_xor, testBit_bit_add]
  | succ i => simp only [Nat.testBit_xor, testBit_bit_add_succ]

theorem lineUpd_length (sym : Bool) : ∀ (syms inc : List Bool) (cin : Bool),
    (lineUpd sym syms inc cin).1.length = min syms.length inc.length ∧
      (lineUpd sym syms inc cin).2.length = min syms.length inc.length
  | [], _, _ => by simp [lineUpd]
  | _ :: _, [], _ => by simp [lineUpd]
  | s :: ss, i :: is, cin => by
    have := lineUpd_length sym ss is (if s == sym then !i else (cin && !i))
    simp only [lineUpd, List.length_cons, this, Nat.add_min_add_right, and_self]

/-- The cross increments are the carries of `¬inc + (¬inc ∧ match) + cin`. -/
theorem lineUpd_carry (sym : Bool) : ∀ (syms inc : List Bool) (cin : Bool), syms.length = inc.length →
    2 * ofL (lineUpd sym syms inc cin).2 + (if cin then 1 else 0) =
      (ofL (inc.map (!·)) + ofL (List.zipWith (fun s i => !i && (s == sym)) syms inc) + (if cin then 1 else 0)) ^^^
        ofL (inc.map (!·)) ^^^ ofL (List.zipWith (fun s i => !i && (s == sym)) syms inc)
  | [], [], cin, _ => by cases cin <;> simp [lineUpd, ofL]
  | [], _ :: _, _, h => by simp at h
  | _ :: _, [], _, h => by simp at h
  | s :: ss, i :: is, cin, h => by
    have ih := lineUpd_carry sym ss is (if s == sym then !i else (cin && !i)) (by simpa using h)
    simp only [lineUpd, List.map_cons, List.zipWith_cons_cons, ofL_cons]
    generalize ofL (List.map (!·) is) = T at ih ⊢
    generalize ofL (List.zipWith (fun s i => !i && (s == sym)) ss is) = G at ih ⊢
    generalize ofL (lineUpd sym ss is (if s == sym then !i else (cin && !i))).2 = R at ih ⊢
    generalize (s == sym) = m at ih ⊢
    have key : (if (!i) = true then 1 else 0) + 2 * T + ((if (!i && m) = true then 1 else 0) + 2 * G) +
        (if cin = true then 1 else 0) =
        (if ((!i) ^^ (!i && m) ^^ cin) = true then 1 else 0) +
          2 * (T + G + if (if m = true then !i else (cin && !i)) = true then 1 else 0) := by
      cases i <;> cases m <;> cases cin <;> simp <;> omega
    rw [key, xor_bit, xor_bit, ← ih]
    cases i <;> cases m <;> cases cin <;> simp <;> omega

/-- The new increments, position by position. -/
theorem lineUpd_ni (sym : Bool) : ∀ (syms inc : List Bool) (cin : Bool) (j : ℕ),
    (lineUpd sym syms inc cin).1.getD j false =
      if j < min syms.length inc.length then
        (if (lineUpd sym syms inc cin).2.getD j false !=
            (if j = 0 then cin else (lineUpd sym syms inc cin).2.getD (j - 1) false)
          then (lineUpd sym syms inc cin).2.getD j false else inc.getD j false)
      else false
  | [], _, _, j => by simp [lineUpd]
  | _ :: _, [], _, j => by simp [lineUpd]
  | s :: ss, i :: is, cin, 0 => by simp [lineUpd]
  | s :: ss, i :: is, cin, j + 1 => by
    have ih := lineUpd_ni sym ss is (if s == sym then !i else (cin && !i)) j
    simp only [lineUpd, List.getD_cons_succ, List.length_cons, Nat.add_min_add_right] at ih ⊢
    rw [ih]
    cases j with
    | zero => simp
    | succ j => simp

theorem getD_map_not (L : List Bool) (j : ℕ) : (L.map (!·)).getD j false = (decide (j < L.length) && !L.getD j false) := by
  by_cases hj : j < L.length
  · simp [List.getD_eq_getElem?_getD, hj]
  · rw [getD_eq_false_of_le (by simpa using hj), getD_eq_false_of_le (by omega)]; simp [hj]

theorem getD_zipWith_match (sym : Bool) (syms inc : List Bool) (hl : syms.length = inc.length) (j : ℕ) :
    (List.zipWith (fun s i => !i && (s == sym)) syms inc).getD j false =
      (decide (j < inc.length) && !inc.getD j false && (syms.getD j false == sym)) := by
  by_cases hj : j < inc.length
  · have hj' : j < syms.length := by omega
    simp [List.getD_eq_getElem?_getD, hj, hj']
  · rw [getD_eq_false_of_le (by simp; omega)]; simp [hj]

/-- `lineUpdM` computes `lineUpd` (cross increment 0 before position 1). -/
theorem lineUpdM_eq (sym : Bool) (syms inc : List Bool) (hl : syms.length = inc.length) :
    lineUpdM (2 ^ inc.length - 1) sym (ofL syms) (ofL inc) =
      (ofL (lineUpd sym syms inc false).1, ofL (lineUpd sym syms inc false).2) := by
  have hT : ofL inc ^^^ (2 ^ inc.length - 1) = ofL (inc.map (!·)) := (ofL_map_not inc).symm
  have hG : ofL (inc.map (!·)) &&& (if sym then ofL syms else ofL syms ^^^ (2 ^ inc.length - 1)) =
      ofL (List.zipWith (fun s i => !i && (s == sym)) syms inc) := by
    apply Nat.eq_of_testBit_eq; intro j
    rw [Nat.testBit_and, testBit_ofL, testBit_ofL, getD_map_not, getD_zipWith_match sym syms inc hl]
    by_cases hj : j < inc.length
    · cases sym <;> simp [testBit_ofL, Nat.testBit_xor, hj]
    · simp [hj]
  have hc := lineUpd_carry sym syms inc false hl
  simp only [Bool.false_eq_true, if_false, add_zero] at hc
  have hcr : ((ofL (inc.map (!·)) + ofL (List.zipWith (fun s i => !i && (s == sym)) syms inc)) ^^^
      (ofL (inc.map (!·)) ^^^ ofL (List.zipWith (fun s i => !i && (s == sym)) syms inc))) >>> 1 =
      ofL (lineUpd sym syms inc false).2 := by
    rw [← Nat.xor_assoc, ← hc, Nat.shiftRight_eq_div_pow]; omega
  obtain ⟨hl1, hl2⟩ := lineUpd_length sym syms inc false
  simp only [lineUpdM, hT, hG, hcr, Prod.mk.injEq, and_true]
  apply Nat.eq_of_testBit_eq; intro j
  simp only [Nat.testBit_or, Nat.testBit_and, Nat.testBit_xor, Nat.testBit_shiftLeft, Nat.testBit_two_pow_sub_one,
    testBit_ofL, lineUpd_ni sym syms inc false j, hl, min_self]
  by_cases hj : j < inc.length
  · cases j with
    | zero => simp [hj]; split <;> simp_all
    | succ j =>
      simp [hj]
      generalize (lineUpd sym syms inc false).2[j + 1]?.getD false = a
      generalize (lineUpd sym syms inc false).2[j]?.getD false = b
      cases a <;> cases b <;> simp
  · rw [getD_eq_false_of_le (by omega : (lineUpd sym syms inc false).2.length ≤ j)]; simp [hj]

/-! ### Regions R1 and R2 on masks -/

theorem shiftLeft_bit_add (b : Bool) (x j : ℕ) :
    ((if b then 1 else 0) + 2 * x) <<< j = ((if b then 1 else 0) <<< j) ||| (x <<< (j + 1)) := by
  apply Nat.eq_of_testBit_eq; intro i
  simp only [Nat.testBit_shiftLeft, Nat.testBit_or]
  by_cases hij : j ≤ i
  · obtain ⟨d, rfl⟩ : ∃ d, i = j + d := ⟨i - j, by omega⟩
    cases d with
    | zero => cases b <;> simp [testBit_bit_add]
    | succ d =>
      rw [show j + (d + 1) - j = d + 1 by omega, testBit_bit_add_succ, show j + (d + 1) - (j + 1) = d by omega]
      cases b <;> simp [Nat.testBit_add_one] <;> omega
  · simp [show ¬(i ≥ j) by omega, show ¬(i ≥ j + 1) by omega]

theorem shiftRight_mod_two_eq_getLastD (L : List Bool) (hL : 1 ≤ L.length) :
    (ofL L >>> (L.length - 1)) % 2 = if L.getLastD false then 1 else 0 := by
  have h1 : (ofL L >>> (L.length - 1)) % 2 = if (ofL L).testBit (L.length - 1) then 1 else 0 := by
    rw [Nat.shiftRight_eq_div_pow, Nat.testBit_eq_decide_div_mod_eq]
    have := Nat.mod_two_eq_zero_or_one (ofL L / 2 ^ (L.length - 1))
    by_cases h : ofL L / 2 ^ (L.length - 1) % 2 = 1 <;> simp [h] <;> omega
  rw [h1, testBit_ofL, List.getLastD_eq_getLast?, List.getLast?_eq_getElem?]
  simp [List.getD_eq_getElem?_getD]

theorem region1M_eq (h : ℕ) (hh : 1 ≤ h) (xs : List Bool) (hx : xs.length = h) :
    ∀ (bs V : List Bool) (j av ah : ℕ), V.length = h →
      region1M (h - 1) (2 ^ h - 1) (ofL xs) (ofL V) bs j av ah =
        (ofL (region1 xs V bs).1, av ||| (ofL ((region1 xs V bs).2.map Prod.fst) <<< j),
          ah ||| (ofL ((region1 xs V bs).2.map Prod.snd) <<< j)) := by
  intro bs
  induction bs with
  | nil => intro V j av ah _; simp [region1M, region1, ofL]
  | cons b bs ih =>
    intro V j av ah hV
    obtain ⟨hl1, hl2⟩ := lineUpd_length b xs V false
    rw [hx, hV, min_self] at hl1 hl2
    have hp := lineUpdM_eq b xs V (by omega)
    rw [hV] at hp
    simp only [region1M, hp, region1]
    rw [ih _ _ _ _ hl1]
    simp only [List.map_cons, ofL_cons, shiftLeft_bit_add, Prod.mk.injEq, true_and]
    have e1 := shiftRight_mod_two_eq_getLastD (lineUpd b xs V false).1 (by omega)
    have e2 := shiftRight_mod_two_eq_getLastD (lineUpd b xs V false).2 (by omega)
    rw [hl1] at e1; rw [hl2] at e2
    rw [e1, e2, Nat.or_assoc, Nat.or_assoc]
    exact ⟨rfl, rfl⟩

/-- Rows of `n` bits packed one after the other. -/
def packRows (n : ℕ) : List ℕ → ℕ
  | [] => 0
  | L :: Ls => L ||| (packRows n Ls <<< n)

theorem or_shiftLeft_pack (n sh x y : ℕ) : (x ||| (y <<< n)) <<< sh = (x <<< sh) ||| (y <<< (sh + n)) := by
  apply Nat.eq_of_testBit_eq; intro i
  simp only [Nat.testBit_shiftLeft, Nat.testBit_or]
  by_cases h1 : sh ≤ i
  · by_cases h2 : sh + n ≤ i
    · simp [h1, h2, show i - sh ≥ n by omega, show i - sh - n = i - (sh + n) by omega]
    · simp [h1, h2, show ¬(i - sh ≥ n) by omega, show ¬(i ≥ sh + n) by omega]
  · simp [show ¬(i ≥ sh) by omega, show ¬(i ≥ sh + n) by omega]

theorem region2_lines (ys : List Bool) : ∀ (as H : List Bool), H.length = ys.length →
    (region2 ys H as).1.length = ys.length ∧ ∀ p ∈ (region2 ys H as).2, p.1.length = ys.length ∧ p.2.length = ys.length := by
  intro as
  induction as with
  | nil => intro H hH; simp [region2, hH]
  | cons a as ih =>
    intro H hH
    obtain ⟨hl1, hl2⟩ := lineUpd_length a ys H false
    rw [hH, min_self] at hl1 hl2
    obtain ⟨ih1, ih2⟩ := ih _ hl1
    simp only [region2, List.mem_cons, forall_eq_or_imp]
    exact ⟨ih1, ⟨hl2, hl1⟩, ih2⟩

theorem region2M_eq (ys : List Bool) : ∀ (as H : List Bool) (j sh av ah ab : ℕ), H.length = ys.length →
    region2M ys.length (2 ^ ys.length - 1) (ofL ys) (ofL H) as j sh av ah ab =
      (ofL (region2 ys H as).1, av ||| (packRows ys.length ((region2 ys H as).2.map fun p => ofL p.1) <<< sh),
        ah ||| (packRows ys.length ((region2 ys H as).2.map fun p => ofL p.2) <<< sh),
        ab ||| (ofL ((region2 ys H as).2.map fun p => p.1.getLastD false) <<< j)) := by
  intro as
  induction as with
  | nil => intro H j sh av ah ab _; simp [region2M, region2, packRows, ofL]
  | cons a as ih =>
    intro H j sh av ah ab hH
    obtain ⟨hl1, hl2⟩ := lineUpd_length a ys H false
    rw [hH, min_self] at hl1 hl2
    have hp := lineUpdM_eq a ys H (by omega)
    rw [hH] at hp
    simp only [region2M, hp, region2]
    rw [ih _ _ _ _ _ _ hl1]
    simp only [List.map_cons, packRows, ofL_cons, shiftLeft_bit_add, or_shiftLeft_pack, Prod.mk.injEq, true_and]
    by_cases hy : 1 ≤ ys.length
    · have e2 := shiftRight_mod_two_eq_getLastD (lineUpd a ys H false).2 (by omega)
      rw [hl2] at e2
      rw [e2, Nat.or_assoc, Nat.or_assoc, Nat.or_assoc]
      exact ⟨rfl, rfl, rfl⟩
    · have h0 : ys.length = 0 := by omega
      have hz : (lineUpd a ys H false).2 = [] := List.eq_nil_of_length_eq_zero (by omega)
      rw [hz]
      simp [ofL, Nat.or_assoc, h0, Nat.add_comm sh 0]

theorem testBit_unpack (n : ℕ) (rows : List (List Bool × List Bool)) (f : List Bool × List Bool → List Bool)
    (hr : ∀ p ∈ rows, (f p).length = n) (hf : f ([], []) = []) (i t : ℕ) :
    ((packRows n (rows.map fun p => ofL (f p)) >>> (n * i)) % 2 ^ n).testBit t =
      (f (rows.getD i ([], []))).getD t false := by
  rw [Nat.testBit_mod_two_pow, Nat.testBit_shiftRight]
  induction rows generalizing i with
  | nil => simp [packRows, hf]
  | cons p ps ih =>
    have hp := hr p List.mem_cons_self
    have hps : ∀ q ∈ ps, (f q).length = n := fun q hq => hr q (List.mem_cons_of_mem _ hq)
    cases i with
    | zero =>
      simp only [packRows, List.map_cons, Nat.mul_zero, Nat.zero_add, Nat.testBit_or, Nat.testBit_shiftLeft,
        testBit_ofL, List.getD_cons_zero]
      by_cases ht : t < n
      · simp [ht, show ¬(t ≥ n) by omega]
      · rw [getD_eq_false_of_le (by omega)]; simp [ht]
    | succ i =>
      simp only [packRows, List.map_cons, Nat.testBit_or, Nat.testBit_shiftLeft, testBit_ofL, List.getD_cons_succ]
      by_cases ht : t < n
      · rw [getD_eq_false_of_le (by rw [hp]; nlinarith)]
        simp only [ht, decide_true, Bool.true_and, Bool.false_or, show n * (i + 1) + t ≥ n by nlinarith]
        rw [show n * (i + 1) + t - n = n * i + t by rw [Nat.mul_succ]; omega]
        have := ih hps i
        simp only [ht, decide_true, Bool.true_and] at this
        exact this
      · have hq : (f (ps.getD i ([], []))).length ≤ n := by
          by_cases hi : i < ps.length
          · rw [List.getD_eq_getElem?_getD, List.getElem?_eq_getElem hi, Option.getD_some]
            exact (hps _ (List.getElem_mem hi)).le
          · rw [List.getD_eq_getElem?_getD, List.getElem?_eq_none (by omega), Option.getD_none, hf]; simp
        simp only [ht, decide_false, Bool.false_and]
        exact (getD_eq_false_of_le (by omega)).symm

/-! ### Bit order of the code fields -/

theorem bitsMSB_succ (n : ℕ) : ∀ m, bitsMSB n (m + 1) = bitsMSB (n >>> 1) m ++ [n.testBit 0]
  | 0 => rfl
  | m + 1 => by
    rw [bitsMSB, bitsMSB_succ n m, bitsMSB, Nat.testBit_shiftRight, Nat.add_comm 1 m, List.cons_append]

theorem ofL_append_add : ∀ (L M : List Bool), ofL (L ++ M) = ofL L + 2 ^ L.length * ofL M
  | [], M => by simp [ofL]
  | b :: L, M => by rw [List.cons_append, ofL_cons, ofL_cons, ofL_append_add L M, List.length_cons, pow_succ]; ring

theorem revBits_eq : ∀ (m n acc : ℕ), revBits m n acc = acc * 2 ^ m + ofL (bitsMSB n m)
  | 0, n, acc => by simp [revBits, bitsMSB, ofL]
  | m + 1, n, acc => by
    rw [revBits, revBits_eq m (n >>> 1) (2 * acc + n % 2), bitsMSB_succ, ofL_append_add, bitsMSB_length]
    have : ofL [n.testBit 0] = n % 2 := by
      rw [ofL_cons, Nat.testBit_zero]; have := Nat.mod_two_eq_zero_or_one n
      rcases this with h | h <;> simp [h, ofL]
    rw [this, pow_succ]; ring

theorem revBits_eq_ofL (m n : ℕ) : revBits m n 0 = ofL (bitsMSB n m) := by
  rw [revBits_eq]; simp

theorem revBits_ofL : ∀ (L : List Bool) (acc : ℕ), revBits L.length (ofL L) acc = ofBitsMSB L acc
  | [], acc => rfl
  | b :: L, acc => by
    rw [List.length_cons, revBits, ofBitsMSB]
    have h1 : ofL (b :: L) >>> 1 = ofL L := by
      rw [ofL_cons, Nat.shiftRight_eq_div_pow]; cases b <;> simp <;> omega
    have h2 : ofL (b :: L) % 2 = if b then 1 else 0 := by rw [ofL_cons]; cases b <;> simp <;> omega
    rw [h1, h2, revBits_ofL L]

theorem region1_length (xs : List Bool) : ∀ (bs V : List Bool), V.length = xs.length →
    (region1 xs V bs).1.length = xs.length ∧ (region1 xs V bs).2.length = bs.length := by
  intro bs
  induction bs with
  | nil => intro V hV; simp [region1, hV]
  | cons b bs ih =>
    intro V hV
    obtain ⟨hl1, -⟩ := lineUpd_length b xs V false
    rw [hV, min_self] at hl1
    obtain ⟨i1, i2⟩ := ih _ hl1
    simp only [region1, List.length_cons]
    exact ⟨i1, by rw [i2]⟩

theorem region2_length (ys : List Bool) (as H : List Bool) : (region2 ys H as).2.length = as.length := by
  induction as generalizing H with
  | nil => simp [region2]
  | cons a as ih => simp only [region2, List.length_cons, ih]

theorem getD_map_fst (L : List (Bool × Bool)) (i : ℕ) : (L.map Prod.fst).getD i false = (L.getD i (false, false)).1 := by
  simp only [List.getD_eq_getElem?_getD, List.getElem?_map]; cases L[i]? <;> rfl

theorem getD_map_snd (L : List (Bool × Bool)) (i : ℕ) : (L.map Prod.snd).getD i false = (L.getD i (false, false)).2 := by
  simp only [List.getD_eq_getElem?_getD, List.getElem?_map]; cases L[i]? <;> rfl

theorem ofL_or_shift (L M : List Bool) (n : ℕ) (hL : L.length = n) : ofL L ||| (ofL M <<< n) = ofL (L ++ M) := by
  rw [ofL_append, hL]

/-! ### The main theorem -/

theorem ofL_map_not' (L : List Bool) (n : ℕ) (hL : L.length = n) : ofL L ^^^ (2 ^ n - 1) = ofL (L.map (!·)) := by
  rw [ofL_map_not, hL]

theorem revBits_ofL' (L : List Bool) (n : ℕ) (hL : L.length = n) : revBits n (ofL L) 0 = ofBitsMSB L 0 := by
  rw [← hL, revBits_ofL]

theorem kstep_eq (h k : ℕ) (hh : 1 ≤ h) (c : Bool) (l : ℤ) : kstep h k c l = stepCode h k c l := by
  unfold kstep stepCode stepLists
  rw [revBits_eq_ofL h (fieldX h k), revBits_eq_ofL h (fieldY h k), revBits_eq_ofL h (fieldDX h k),
    revBits_eq_ofL h (fieldDY h k)]
  have hxl := bitsMSB_length (fieldX h k) h
  have hyl := bitsMSB_length (fieldY h k) h
  have hdxl := bitsMSB_length (fieldDX h k) h
  have hdyl := bitsMSB_length (fieldDY h k) h
  generalize bitsMSB (fieldX h k) h = xs at *
  generalize bitsMSB (fieldY h k) h = ys at *
  generalize bitsMSB (fieldDX h k) h = dxs at *
  generalize bitsMSB (fieldDY h k) h = dys at *
  generalize topStr c l = top
  generalize botStr c l = bot
  dsimp only
  -- region R1
  rw [region1M_eq h hh xs hxl bot dxs 0 0 0 hdxl]
  obtain ⟨hR1a, hR1b⟩ := region1_length xs bot dxs (by rw [hdxl, hxl])
  generalize region1 xs dxs bot = R1 at *
  simp only [Nat.shiftLeft_zero, Nat.zero_or]
  rw [ofL_or_shift ys bot h hyl, ofL_or_shift xs top h hxl,
    ofL_or_shift dys (R1.2.map Prod.snd) h hdyl]
  -- region R2
  have hH0 : (dys ++ R1.2.map Prod.snd).length = (ys ++ bot).length := by simp [hdyl, hyl, hR1b]
  have hR2 := region2M_eq (ys ++ bot) top (dys ++ R1.2.map Prod.snd) 0 0 0 0 0 hH0
  obtain ⟨hl0, hlines⟩ := region2_lines (ys ++ bot) top (dys ++ R1.2.map Prod.snd) hH0
  have hR2len := region2_length (ys ++ bot) top (dys ++ R1.2.map Prod.snd)
  generalize region2 (ys ++ bot) (dys ++ R1.2.map Prod.snd) top = R2 at *
  simp only [List.length_append, hyl] at hR2 hl0 hlines
  rw [hR2]
  simp only [Nat.shiftLeft_zero, Nat.zero_or]
  -- the traceback reads the same increments
  have h1 : ∀ p ∈ R2.2, (Prod.fst p).length = h + bot.length := fun p hp => (hlines p hp).1
  have h2 : ∀ p ∈ R2.2, (Prod.snd p).length = h + bot.length := fun p hp => (hlines p hp).2
  simp only [testBit_ofL, getD_map_fst, getD_map_snd, testBit_unpack (h + bot.length) R2.2 Prod.fst h1 rfl,
    testBit_unpack (h + bot.length) R2.2 Prod.snd h2 rfl]
  -- the outputs
  rw [← ofL_drop, ← ofL_drop, ← ofL_drop, ofL_or_shift R1.1 _ h (by rw [hR1a, hxl]), ← ofL_drop, ofL_mod_two]
  have hX : ((xs ++ top).drop top.length).length = h := by simp [hxl]
  have hY : ((ys ++ bot).drop bot.length).length = h := by simp [hyl]
  rw [ofL_map_not' _ h hX, ofL_map_not' _ h hY]
  have hb : ∀ b : Bool, ((if b = true then 1 else 0) = 1) = (b = true) := by decide
  simp only [hb]
  rw [← apply_ite ofL, ← apply_ite ofL]
  split
  · rename_i hT
    simp only [hT, ↓reduceIte]
    have hDX : (List.drop top.length (R1.1 ++ List.map (fun p => p.1.getLastD false) R2.2)).length = h := by
      simp [hR1a, hxl, hR2len]
    have hDY : (List.drop bot.length R2.1).length = h := by simp [hl0]
    have hX' : (if (List.drop top.length (xs ++ top)).headD false = true then
        List.map (fun x => !x) (List.drop top.length (xs ++ top)) else List.drop top.length (xs ++ top)).length = h := by
      split <;> simp [hxl]
    have hY' : (if (List.drop top.length (xs ++ top)).headD false = true then
        List.map (fun x => !x) (List.drop bot.length (ys ++ bot)) else List.drop bot.length (ys ++ bot)).length = h := by
      split <;> simp [hyl]
    rw [revBits_ofL' _ h hX', revBits_ofL' _ h hY', revBits_ofL' _ h hDX, revBits_ofL' _ h hDY]
  · rename_i hT
    simp only [hT, ↓reduceIte, Bool.false_eq_true]

/-! ### The kernel checker with `kstep` -/

theorem rowTermsK_eq (h : ℕ) (hh : 1 ≤ h) (find : ℕ → Option ℕ) (wt : List ℕ) (k : ℕ) :
    ∀ ps : List (Bool × ℤ), rowTermsK h find wt k ps = rowTerms h find wt k ps
  | [] => rfl
  | (c, l) :: ps => by
    simp only [rowTermsK, rowTerms, kstep_eq h k hh c l, rowTermsK_eq h hh find wt k ps]
    rfl

theorem rowOKK_eq (h : ℕ) (hh : 1 ≤ h) (find : ℕ → Option ℕ) (wt : List ℕ) (lam k u : ℕ) :
    rowOKK h find wt lam k u = rowOK h find wt lam k u := by
  unfold rowOKK rowOK; rw [rowTermsK_eq h hh]; rfl

theorem checkKK_eq {h : ℕ} (hh : 1 ≤ h) (t : KTree) (wt : List ℕ) (lam : ℕ) (sub : KTree) :
    checkKK h t wt lam sub = checkK h t wt lam sub := by
  unfold checkKK checkK
  congr 1; funext k u; exact rowOKK_eq h hh _ wt lam k u

/-- Combining shards checked with `checkKK`. -/
theorem checkK_of_shardsKK {h : ℕ} (hh : 1 ≤ h) {t : KTree} {wt : List ℕ} {lam : ℕ} (T : KTree) (d : ℕ)
    (hs : ∀ path ∈ allPaths d, checkKK h t wt lam (T.sub path) = true) : checkK h t wt lam T = true :=
  checkK_of_shards T d fun path hp => by rw [← checkKK_eq hh]; exact hs path hp

end CS31a
