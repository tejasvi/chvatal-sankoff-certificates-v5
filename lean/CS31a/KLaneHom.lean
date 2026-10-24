import CS31a.KLaneScalar

/-!
# The packed transition acts lane by lane

Lane `j < L` of `kstepLeafL h L keys c l` is the transition `kstepLeafL h 1 (lane j keys) c l` of the single lane
`lane j keys` (`lane_kstepLeafL`). Each packed function commutes with `lane i` (`i < L`) under bounds on the lanes
`< L` of its arguments: bitwise operations always, a right shift followed by a lane mask always, a left shift if the
lanes are small, the addition of a line update because it never carries out of a lane.
-/

namespace CS31a

open CS31aCert

/-! ### Generic lane facts -/

theorem A_one_lt_two_pow {n : ℕ} (hn : 0 < n) : 1 < 2 ^ n := Nat.one_lt_two_pow (by omega)

theorem A_two_pow_le {a b : ℕ} (hab : a ≤ b) : 2 ^ a ≤ 2 ^ b := Nat.pow_le_pow_right (by norm_num) hab

theorem A_lane_rep {v L i : ℕ} (hv : v < 2 ^ 64) (hi : i < L) : lane i (laneRepL v L) = v := by
  rw [lane_laneRepL hv]; simp [hi]

theorem A_lane_zero (i : ℕ) : lane i 0 = 0 := by simp [lane]

/-- A left shift of a number whose lanes `< L` are below `2^w` (`w + k ≤ 64`) acts on each lane `i < L`. -/
theorem A_lane_shiftLeft {L w k i x : ℕ} (hwk : w + k ≤ 64) (hx : ∀ i < L, lane i x < 2 ^ w) (hi : i < L) :
    lane i (x <<< k) = lane i x <<< k := by
  have hle : 2 ^ w ≤ 2 ^ (64 - k) := A_two_pow_le (by omega)
  apply lane_shiftLeft i x (by omega)
  · rcases Nat.eq_zero_or_pos i with h0 | hpos
    · exact Or.inl h0
    · exact Or.inr (lt_of_lt_of_le (hx (i - 1) (by omega)) hle)
  · exact lt_of_lt_of_le (hx i hi) hle

theorem A_shiftLeft_lt {x a k : ℕ} (hx : x < 2 ^ a) : x <<< k < 2 ^ (a + k) := by
  rw [Nat.shiftLeft_eq, Nat.pow_add]; exact Nat.mul_lt_mul_of_pos_right hx (by positivity)

/-! ### Bit reversal -/

/-- One stage of the reversal network. -/
def A_rstage (k m x : ℕ) : ℕ := ((x >>> k) &&& m) ||| ((x &&& m) <<< k)

theorem A_revLanesL_eq (L h x : ℕ) : revLanesL L h x =
    (A_rstage 32 (laneRepL 0x00000000FFFFFFFF L) (A_rstage 16 (laneRepL 0x0000FFFF0000FFFF L)
      (A_rstage 8 (laneRepL 0x00FF00FF00FF00FF L) (A_rstage 4 (laneRepL 0x0F0F0F0F0F0F0F0F L)
      (A_rstage 2 (laneRepL 0x3333333333333333 L) (A_rstage 1 (laneRepL 0x5555555555555555 L) x)))))
      >>> (64 - h)) &&& laneRepL (2 ^ h - 1) L := rfl

theorem A_lane_rstage {L i k M : ℕ} (hi : i < L) (hk : k ≤ 64) (hM : M < 2 ^ (64 - k)) (x : ℕ) :
    lane i (A_rstage k (laneRepL M L) x) = A_rstage k M (lane i x) := by
  have hM64 : M < 2 ^ 64 := lt_of_lt_of_le hM (A_two_pow_le (by omega))
  have hrep : ∀ i < L, lane i (laneRepL M L) = M := fun i hi => A_lane_rep hM64 hi
  unfold A_rstage
  rw [lane_lor, lane_shiftRight_land _ _ _ (by rw [hrep i hi]; exact hM), hrep i hi,
    A_lane_shiftLeft (w := 64 - k) (by omega)
      (fun i' hi' => by rw [lane_land, hrep i' hi']; exact lt_of_le_of_lt Nat.and_le_right hM) hi,
    lane_land, hrep i hi]

/-- `revLanesL` acts on each lane `i < L`. -/
theorem A_lane_revLanesL {L h i : ℕ} (hi : i < L) (hh : h ≤ 64) (x : ℕ) :
    lane i (revLanesL L h x) = revLanesL 1 h (lane i x) := by
  have hm : 2 ^ h - 1 < 2 ^ (64 - (64 - h)) := by
    rw [show 64 - (64 - h) = h by omega]; have := Nat.one_le_two_pow (n := h); omega
  have hm64 : 2 ^ h - 1 < 2 ^ 64 := lt_of_lt_of_le hm (A_two_pow_le (by omega))
  rw [A_revLanesL_eq, A_revLanesL_eq]
  simp only [laneRepL_one]
  rw [lane_shiftRight_land _ _ _ (by rw [A_lane_rep hm64 hi]; exact hm), A_lane_rep hm64 hi,
    A_lane_rstage hi (by norm_num) (by norm_num), A_lane_rstage hi (by norm_num) (by norm_num),
    A_lane_rstage hi (by norm_num) (by norm_num), A_lane_rstage hi (by norm_num) (by norm_num),
    A_lane_rstage hi (by norm_num) (by norm_num), A_lane_rstage hi (by norm_num) (by norm_num)]

theorem A_revLanesL_one_lt {h : ℕ} (hh : h ≤ 64) (x : ℕ) : revLanesL 1 h x < 2 ^ h := by
  rw [revLanesL_one_eq hh]; exact revBits_lt h x

/-! ### Filling down -/

/-- One stage of `fillDownL`. -/
def A_fstage (k fw x : ℕ) : ℕ := x ||| ((x >>> k) &&& fw)

theorem A_fillDownL_eq (fw x : ℕ) : fillDownL fw x =
    A_fstage 32 fw (A_fstage 16 fw (A_fstage 8 fw (A_fstage 4 fw (A_fstage 2 fw (A_fstage 1 fw x))))) := rfl

theorem A_lane_fstage {i k fw : ℕ} (hfw : lane i fw < 2 ^ (64 - k)) (x : ℕ) :
    lane i (A_fstage k fw x) = A_fstage k (lane i fw) (lane i x) := by
  unfold A_fstage; rw [lane_lor, lane_shiftRight_land _ _ _ hfw]

/-- `fillDownL` acts on lane `i` if the mask lane is below `2^32`. -/
theorem A_lane_fillDownL {i fw : ℕ} (hfw : lane i fw < 2 ^ 32) (x : ℕ) :
    lane i (fillDownL fw x) = fillDownL (lane i fw) (lane i x) := by
  have hk : ∀ k ≤ 32, lane i fw < 2 ^ (64 - k) := fun k hk => lt_of_lt_of_le hfw (A_two_pow_le (by omega))
  rw [A_fillDownL_eq, A_fillDownL_eq, A_lane_fstage (hk 32 le_rfl), A_lane_fstage (hk 16 (by norm_num)),
    A_lane_fstage (hk 8 (by norm_num)), A_lane_fstage (hk 4 (by norm_num)), A_lane_fstage (hk 2 (by norm_num)),
    A_lane_fstage (hk 1 (by norm_num))]

/-! ### Spreading bit 0 -/

/-- One stage of `spreadL`. -/
def A_sstage (k x : ℕ) : ℕ := x ||| (x <<< k)

theorem A_spreadL_eq (fh x : ℕ) :
    spreadL fh x = A_sstage 16 (A_sstage 8 (A_sstage 4 (A_sstage 2 (A_sstage 1 x)))) &&& fh := rfl

theorem A_sstage_lt {w k x : ℕ} (hx : x < 2 ^ w) : A_sstage k x < 2 ^ (w + k) :=
  Nat.or_lt_two_pow (lt_of_lt_of_le hx (A_two_pow_le (by omega))) (A_shiftLeft_lt hx)

theorem A_lane_sstage {L w k x : ℕ} (hwk : w + k ≤ 64) (hx : ∀ i < L, lane i x < 2 ^ w) :
    ∀ i < L, lane i (A_sstage k x) = A_sstage k (lane i x) ∧ lane i (A_sstage k x) < 2 ^ (w + k) := by
  intro i hi
  have e : lane i (A_sstage k x) = A_sstage k (lane i x) := by
    unfold A_sstage; rw [lane_lor, A_lane_shiftLeft hwk hx hi]
  exact ⟨e, e ▸ A_sstage_lt (hx i hi)⟩

/-- `spreadL` acts on each lane `i < L` if the lanes `< L` of the argument are at most `1`. -/
theorem A_lane_spreadL {L i fh x : ℕ} (hi : i < L) (hx : ∀ i < L, lane i x < 2 ^ 1) :
    lane i (spreadL fh x) = spreadL (lane i fh) (lane i x) := by
  have s1 := A_lane_sstage (k := 1) (by norm_num) hx
  have s2 := A_lane_sstage (k := 2) (by norm_num) (fun i hi => (s1 i hi).2)
  have s4 := A_lane_sstage (k := 4) (by norm_num) (fun i hi => (s2 i hi).2)
  have s8 := A_lane_sstage (k := 8) (by norm_num) (fun i hi => (s4 i hi).2)
  have s16 := A_lane_sstage (k := 16) (by norm_num) (fun i hi => (s8 i hi).2)
  rw [A_spreadL_eq, A_spreadL_eq, lane_land, (s16 i hi).1, (s8 i hi).1, (s4 i hi).1, (s2 i hi).1, (s1 i hi).1]

/-! ### Line update -/

/-- The lanes of a pair. -/
def A_lp (i : ℕ) (p : ℕ × ℕ) : ℕ × ℕ := (lane i p.1, lane i p.2)

theorem A_lp_mk (i a b : ℕ) : A_lp i (a, b) = (lane i a, lane i b) := rfl

/-- The cross increments of `lineUpdL`. -/
def A_cr (full m inc : ℕ) : ℕ :=
  ((((inc ^^^ full) + ((inc ^^^ full) &&& m)) ^^^ ((inc ^^^ full) ^^^ ((inc ^^^ full) &&& m))) >>> 1) &&& full

theorem A_lineUpdL_eq (full m inc : ℕ) : lineUpdL full m inc =
    (((A_cr full m inc ^^^ ((A_cr full m inc <<< 1) &&& full)) &&& A_cr full m inc) |||
      (inc &&& ((A_cr full m inc ^^^ ((A_cr full m inc <<< 1) &&& full)) ^^^ full)), A_cr full m inc) := rfl

theorem A_lane_cr {L i full m inc : ℕ} (hi : i < L) (hfull : ∀ i < L, lane i full < 2 ^ 63)
    (hinc : ∀ i < L, lane i inc < 2 ^ 63) :
    lane i (A_cr full m inc) = A_cr (lane i full) (lane i m) (lane i inc) := by
  unfold A_cr
  rw [lane_shiftRight_land _ _ _ (lt_of_lt_of_eq (hfull i hi) (by norm_num)), lane_xor, lane_add]
  · simp only [lane_xor, lane_land]
  · intro i' hi'
    simp only [lane_xor, lane_land]
    have h1 := hfull i' (by omega)
    have h2 := hinc i' (by omega)
    have h3 : lane i' inc ^^^ lane i' full < 2 ^ 63 := Nat.xor_lt_two_pow h2 h1
    have h4 : (lane i' inc ^^^ lane i' full) &&& lane i' m ≤ lane i' inc ^^^ lane i' full := Nat.and_le_left
    have : (2:ℕ) ^ 64 = 2 ^ 63 + 2 ^ 63 := by norm_num
    omega

/-- `lineUpdL` acts on each lane `i < L` if the lanes `< L` of `full` and `inc` are below `2^63`. -/
theorem A_lane_lineUpdL {L i full m inc : ℕ} (hi : i < L) (hfull : ∀ i < L, lane i full < 2 ^ 63)
    (hinc : ∀ i < L, lane i inc < 2 ^ 63) :
    A_lp i (lineUpdL full m inc) = lineUpdL (lane i full) (lane i m) (lane i inc) := by
  have hcr : ∀ i < L, lane i (A_cr full m inc) = A_cr (lane i full) (lane i m) (lane i inc) :=
    fun i hi => A_lane_cr hi hfull hinc
  have hcrlt : ∀ i < L, lane i (A_cr full m inc) < 2 ^ 63 := by
    intro i hi; rw [hcr i hi]; unfold A_cr; exact lt_of_le_of_lt Nat.and_le_right (hfull i hi)
  rw [A_lineUpdL_eq, A_lineUpdL_eq, A_lp_mk]
  simp only [lane_lor, lane_land, lane_xor]
  rw [A_lane_shiftLeft (w := 63) (by norm_num) hcrlt hi, hcr i hi]

theorem A_lane_symMask (i xs full : ℕ) (b : Bool) :
    lane i (Bool.rec (motive := fun _ => ℕ) (Nat.xor xs full) xs b) =
      Bool.rec (motive := fun _ => ℕ) (Nat.xor (lane i xs) (lane i full)) (lane i xs) b := by
  cases b
  · exact lane_xor i xs full
  · rfl

/-- The accumulator update of the region loops: bit `hm1` of each lane (masked by `one`) moved to bit `j`. -/
theorem A_lane_bitShift {L hm1 j i one y : ℕ} (hm : hm1 < 64) (hj : j < 64) (hone : ∀ i < L, lane i one ≤ 1)
    (hi : i < L) : lane i (((y >>> hm1) &&& one) <<< j) = ((lane i y >>> hm1) &&& lane i one) <<< j := by
  have h1 : ∀ i < L, lane i ((y >>> hm1) &&& one) < 2 ^ 1 := by
    intro i' hi'; rw [lane_land]; have := hone i' hi'
    exact lt_of_le_of_lt Nat.and_le_right (by omega)
  rw [A_lane_shiftLeft (w := 1) (by omega) h1 hi,
    lane_shiftRight_land _ _ _ (lt_of_le_of_lt (hone i hi) (A_one_lt_two_pow (by omega)))]

theorem A_acc_lt {av j hm1 one y : ℕ} (hav : av < 2 ^ j) (hone : one ≤ 1) :
    av ||| (((y >>> hm1) &&& one) <<< j) < 2 ^ (j + 1) := by
  have h1 : (y >>> hm1) &&& one < 2 ^ 1 := lt_of_le_of_lt Nat.and_le_right (by omega)
  have h2 := A_shiftLeft_lt (k := j) h1
  rw [Nat.add_comm 1 j] at h2
  exact Nat.or_lt_two_pow (lt_of_lt_of_le hav (A_two_pow_le (by omega))) h2

/-! ### Region R1 -/

/-- The lanes of a triple. -/
def A_l3 (i : ℕ) (p : ℕ × ℕ × ℕ) : ℕ × ℕ × ℕ := (lane i p.1, lane i p.2.1, lane i p.2.2)

theorem A_region1L_cons (hm1 fullh one xs : ℕ) (b : Bool) (bs : List Bool) (V j av ah : ℕ) :
    region1L hm1 fullh one xs (b :: bs) V j av ah =
      region1L hm1 fullh one xs bs (lineUpdL fullh (Bool.rec (motive := fun _ => ℕ) (Nat.xor xs fullh) xs b) V).1
        (j + 1)
        (av ||| ((((lineUpdL fullh (Bool.rec (motive := fun _ => ℕ) (Nat.xor xs fullh) xs b) V).1 >>> hm1) &&& one)
          <<< j))
        (ah ||| ((((lineUpdL fullh (Bool.rec (motive := fun _ => ℕ) (Nat.xor xs fullh) xs b) V).2 >>> hm1) &&& one)
          <<< j)) := rfl

/-- `region1L` acts on each lane `i < L` (lanes `< L` of `fullh` equal to `2^w - 1`, of `V` below `2^w`). -/
theorem A_lane_region1L {L w hm1 fullh one xs : ℕ} (hw : w ≤ 63) (hm : hm1 < 64)
    (hfull : ∀ i < L, lane i fullh = 2 ^ w - 1) (hone : ∀ i < L, lane i one ≤ 1) :
    ∀ (bs : List Bool) (V j av ah : ℕ), j + bs.length ≤ 64 → (∀ i < L, lane i V < 2 ^ w) →
      ∀ i < L, A_l3 i (region1L hm1 fullh one xs bs V j av ah) =
        region1L hm1 (lane i fullh) (lane i one) (lane i xs) bs (lane i V) j (lane i av) (lane i ah) := by
  have hw63 : (2:ℕ) ^ w ≤ 2 ^ 63 := A_two_pow_le hw
  have hfull63 : ∀ i < L, lane i fullh < 2 ^ 63 := fun i hi => by
    rw [hfull i hi]; have := Nat.one_le_two_pow (n := w); omega
  intro bs
  induction bs with
  | nil => intro V j av ah _ _ i _; rfl
  | cons b bs ih =>
    intro V j av ah hj hV i hi
    simp only [List.length_cons] at hj
    have hV63 : ∀ i < L, lane i V < 2 ^ 63 := fun i hi => lt_of_lt_of_le (hV i hi) hw63
    have hp : ∀ i < L, A_lp i (lineUpdL fullh (Bool.rec (motive := fun _ => ℕ) (Nat.xor xs fullh) xs b) V) =
        lineUpdL (lane i fullh) (Bool.rec (motive := fun _ => ℕ) (Nat.xor (lane i xs) (lane i fullh)) (lane i xs) b)
          (lane i V) := by
      intro i hi; rw [A_lane_lineUpdL hi hfull63 hV63, A_lane_symMask]
    have hp1 : ∀ i < L,
        lane i (lineUpdL fullh (Bool.rec (motive := fun _ => ℕ) (Nat.xor xs fullh) xs b) V).1 < 2 ^ w := by
      intro i hi
      have e := congrArg Prod.fst (hp i hi)
      simp only [A_lp] at e
      rw [e, hfull i hi, lineUpdL_one (hV i hi)]
      exact lineUpdM_fst_lt (hV i hi) _ _
    have e1 := congrArg Prod.fst (hp i hi)
    have e2 := congrArg Prod.snd (hp i hi)
    simp only [A_lp] at e1 e2
    rw [A_region1L_cons, A_region1L_cons, ih _ (j + 1) _ _ (by omega) hp1 i hi, lane_lor, lane_lor,
      A_lane_bitShift (j := j) hm (by omega) hone hi, A_lane_bitShift (j := j) hm (by omega) hone hi, e1, e2]

/-- Bounds of the accumulators of `region1L` (one lane). -/
theorem A_region1L_bound {hm1 fullh one xs : ℕ} (hone : one ≤ 1) :
    ∀ (bs : List Bool) (V j av ah : ℕ), av < 2 ^ j → ah < 2 ^ j →
      (region1L hm1 fullh one xs bs V j av ah).2.1 < 2 ^ (j + bs.length) ∧
        (region1L hm1 fullh one xs bs V j av ah).2.2 < 2 ^ (j + bs.length) := by
  intro bs
  induction bs with
  | nil => intro V j av ah hav hah; exact ⟨hav, hah⟩
  | cons b bs ih =>
    intro V j av ah hav hah
    rw [A_region1L_cons, List.length_cons, show j + (bs.length + 1) = j + 1 + bs.length by omega]
    exact ih _ _ _ _ (A_acc_lt hav hone) (A_acc_lt hah hone)

/-! ### Region R2 -/

/-- The lanes of a result of `region2L` (the rows mapped lane-wise). -/
def A_lr (i : ℕ) (p : ℕ × List (ℕ × ℕ) × ℕ) : ℕ × List (ℕ × ℕ) × ℕ :=
  (lane i p.1, p.2.1.map (A_lp i), lane i p.2.2)

theorem A_region2L_cons (bm1 fullb one ys : ℕ) (a : Bool) (as : List Bool) (H j : ℕ) (rows : List (ℕ × ℕ))
    (ab : ℕ) :
    region2L bm1 fullb one ys (a :: as) H j rows ab =
      region2L bm1 fullb one ys as (lineUpdL fullb (Bool.rec (motive := fun _ => ℕ) (Nat.xor ys fullb) ys a) H).1
        (j + 1)
        (((lineUpdL fullb (Bool.rec (motive := fun _ => ℕ) (Nat.xor ys fullb) ys a) H).2,
          (lineUpdL fullb (Bool.rec (motive := fun _ => ℕ) (Nat.xor ys fullb) ys a) H).1) :: rows)
        (ab ||| ((((lineUpdL fullb (Bool.rec (motive := fun _ => ℕ) (Nat.xor ys fullb) ys a) H).2 >>> bm1) &&& one)
          <<< j)) := rfl

/-- `region2L` acts on each lane `i < L` (lanes `< L` of `fullb` equal to `2^w - 1`, of `H` below `2^w`). -/
theorem A_lane_region2L {L w bm1 fullb one ys : ℕ} (hw : w ≤ 63) (hm : bm1 < 64)
    (hfull : ∀ i < L, lane i fullb = 2 ^ w - 1) (hone : ∀ i < L, lane i one ≤ 1) :
    ∀ (as : List Bool) (H j : ℕ) (rows : List (ℕ × ℕ)) (ab : ℕ), j + as.length ≤ 64 →
      (∀ i < L, lane i H < 2 ^ w) →
      ∀ i < L, A_lr i (region2L bm1 fullb one ys as H j rows ab) =
        region2L bm1 (lane i fullb) (lane i one) (lane i ys) as (lane i H) j (rows.map (A_lp i)) (lane i ab) := by
  have hw63 : (2:ℕ) ^ w ≤ 2 ^ 63 := A_two_pow_le hw
  have hfull63 : ∀ i < L, lane i fullb < 2 ^ 63 := fun i hi => by
    rw [hfull i hi]; have := Nat.one_le_two_pow (n := w); omega
  intro as
  induction as with
  | nil => intro H j rows ab _ _ i _; rfl
  | cons a as ih =>
    intro H j rows ab hj hH i hi
    simp only [List.length_cons] at hj
    have hH63 : ∀ i < L, lane i H < 2 ^ 63 := fun i hi => lt_of_lt_of_le (hH i hi) hw63
    have hp : ∀ i < L, A_lp i (lineUpdL fullb (Bool.rec (motive := fun _ => ℕ) (Nat.xor ys fullb) ys a) H) =
        lineUpdL (lane i fullb) (Bool.rec (motive := fun _ => ℕ) (Nat.xor (lane i ys) (lane i fullb)) (lane i ys) a)
          (lane i H) := by
      intro i hi; rw [A_lane_lineUpdL hi hfull63 hH63, A_lane_symMask]
    have hp1 : ∀ i < L,
        lane i (lineUpdL fullb (Bool.rec (motive := fun _ => ℕ) (Nat.xor ys fullb) ys a) H).1 < 2 ^ w := by
      intro i hi
      have e := congrArg Prod.fst (hp i hi)
      simp only [A_lp] at e
      rw [e, hfull i hi, lineUpdL_one (hH i hi)]
      exact lineUpdM_fst_lt (hH i hi) _ _
    have e1 := congrArg Prod.fst (hp i hi)
    have e2 := congrArg Prod.snd (hp i hi)
    simp only [A_lp] at e1 e2
    rw [A_region2L_cons, A_region2L_cons, ih _ (j + 1) _ _ (by omega) hp1 i hi, List.map_cons, A_lp_mk, lane_lor,
      A_lane_bitShift (j := j) hm (by omega) hone hi, e1, e2]

/-- Bound of the accumulator of `region2L` (one lane). -/
theorem A_region2L_bound {bm1 fullb one ys : ℕ} (hone : one ≤ 1) :
    ∀ (as : List Bool) (H j : ℕ) (rows : List (ℕ × ℕ)) (ab : ℕ), ab < 2 ^ j →
      (region2L bm1 fullb one ys as H j rows ab).2.2 < 2 ^ (j + as.length) := by
  intro as
  induction as with
  | nil => intro H j rows ab hab; exact hab
  | cons a as ih =>
    intro H j rows ab hab
    rw [A_region2L_cons, List.length_cons, show j + (as.length + 1) = j + 1 + as.length by omega]
    exact ih _ _ _ _ (A_acc_lt hab hone)

/-! ### Traceback -/

/-- The filled-down stop candidates of a traceback step. -/
noncomputable def A_tf (fullb geh : ℕ) (vh : ℕ × ℕ) (pos : ℕ) : ℕ :=
  fillDownL fullb ((((vh.1 ^^^ fullb) ||| vh.2) &&& fillDownL fullb pos) &&& geh)

/-- The stop column of a traceback step. -/
def A_tstop (fullb f : ℕ) : ℕ := f &&& (f ^^^ ((f >>> 1) &&& fullb))

theorem A_traceRowsL_cons (fullb geh one : ℕ) (vh : ℕ × ℕ) (rows : List (ℕ × ℕ)) (alive pos : ℕ) :
    traceRowsL fullb geh one (vh :: rows) alive pos =
      traceRowsL fullb geh one rows ((alive &&& A_tf fullb geh vh pos) &&& one)
        ((A_tstop fullb (A_tf fullb geh vh pos) ^^^ (vh.1 &&& A_tstop fullb (A_tf fullb geh vh pos))) |||
          (((vh.1 &&& A_tstop fullb (A_tf fullb geh vh pos)) >>> 1) &&& fullb)) := rfl

theorem A_lane_tf {i fullb : ℕ} (hfb : lane i fullb < 2 ^ 32) (geh : ℕ) (vh : ℕ × ℕ) (pos : ℕ) :
    lane i (A_tf fullb geh vh pos) = A_tf (lane i fullb) (lane i geh) (A_lp i vh) (lane i pos) := by
  unfold A_tf A_lp
  rw [A_lane_fillDownL hfb, lane_land, lane_land, A_lane_fillDownL hfb, lane_lor, lane_xor]

theorem A_lane_tstop {i fullb : ℕ} (hfb : lane i fullb < 2 ^ 32) (f : ℕ) :
    lane i (A_tstop fullb f) = A_tstop (lane i fullb) (lane i f) := by
  unfold A_tstop
  rw [lane_land, lane_xor, lane_shiftRight_land _ _ _ (lt_of_lt_of_le hfb (A_two_pow_le (by norm_num)))]

/-- The traceback acts on lane `i` if the mask lane is below `2^32` (the rows mapped lane-wise). -/
theorem A_lane_traceRowsL {i fullb geh one : ℕ} (hfb : lane i fullb < 2 ^ 32) :
    ∀ (rows : List (ℕ × ℕ)) (alive pos : ℕ), A_lp i (traceRowsL fullb geh one rows alive pos) =
      traceRowsL (lane i fullb) (lane i geh) (lane i one) (rows.map (A_lp i)) (lane i alive) (lane i pos) := by
  intro rows
  induction rows with
  | nil => intro alive pos; rfl
  | cons vh rows ih =>
    intro alive pos
    rw [A_traceRowsL_cons, List.map_cons, A_traceRowsL_cons, ih, lane_land, lane_land, lane_lor,
      lane_shiftRight_land _ _ _ (lt_of_lt_of_le hfb (A_two_pow_le (by norm_num))), lane_xor, lane_land,
      A_lane_tstop hfb, A_lane_tf hfb]
    rfl

/-! ### The shape of the window table -/

theorem A_lengthF_eq {α : Type} : ∀ L : List α, lengthF L = L.length
  | [] => rfl
  | _ :: L => by show lengthF L + 1 = _; rw [A_lengthF_eq L, List.length_cons]

theorem A_ofLF_eq : ∀ L : List Bool, ofLF L = ofL L
  | [] => rfl
  | b :: L => by
    show cond b 1 0 + 2 * ofLF L = ofL (b :: L)
    rw [A_ofLF_eq L, ofL_cons]; cases b <;> rfl

theorem A_ofLF_lt (L : List Bool) : ofLF L < 2 ^ L.length := by rw [A_ofLF_eq]; exact ofL_lt L

theorem A_topStr_length {c : Bool} {l : ℤ} {h : ℕ} (hh1 : 1 ≤ h) (hl : l.natAbs < h) :
    (topStr c l).length ≤ h := by
  unfold topStr
  split_ifs with h0
  · simp only [List.length_append, List.length_replicate, List.length_singleton]; omega
  · simp only [List.length_singleton]; omega

theorem A_botStr_length {c : Bool} {l : ℤ} {h : ℕ} (hh1 : 1 ≤ h) (hl : l.natAbs < h) :
    (botStr c l).length ≤ h := by
  unfold botStr
  split_ifs with h0
  · simp only [List.length_singleton]; omega
  · simp only [List.length_append, List.length_replicate, List.length_singleton]; omega

theorem A_mask_lt {a k : ℕ} (hk : a + k ≤ 64) : 2 ^ a - 1 < 2 ^ (64 - k) := by
  have h1 : 2 ^ a ≤ 2 ^ (64 - k) := A_two_pow_le (by omega)
  have h2 := Nat.one_le_two_pow (n := a)
  omega

/-! ### The packed transition -/

/-- Lane `j < L` of the packed transition of `L` lanes is the transition of the single lane `lane j keys`. -/
theorem lane_kstepLeafL {h L : ℕ} (keys : ℕ) (hh1 : 1 ≤ h) (hh : h ≤ 16) {j : ℕ} (hj : j < L)
    (c : Bool) (l : ℤ) (hl : l.natAbs < h) :
    lane j (kstepLeafL h L keys c l).1 = (kstepLeafL h 1 (lane j keys) c l).1 ∧
      lane j (kstepLeafL h L keys c l).2 = (kstepLeafL h 1 (lane j keys) c l).2 := by
  unfold kstepLeafL
  simp -zeta only [land_eq', lor_eq', xor_eq', shiftRight_eq', shiftLeft_eq', add_eq', sub_eq', mul_eq', pow_eq',
    laneRepL_one]
  extract_lets one fullh xs ys dxs dys top bot nt nb β fullb r1 ysAll r2 geh t eh bad atleast acc x' y' dx' dy' flm
    one1 fullh1 xs1 ys1 dxs1 dys1 fullb1 r11 ysAll1 r21 geh1 t1 eh1 bad1 atleast1 acc1 x'1 y'1 dx'1 dy'1 flm1
  -- the shape
  have htop : top.length ≤ h := A_topStr_length hh1 hl
  have hbot : bot.length ≤ h := A_botStr_length hh1 hl
  have hnt : nt = top.length := A_lengthF_eq top
  have hnb : nb = bot.length := A_lengthF_eq bot
  have hβ : β = h + bot.length := by show h + nb = h + bot.length; rw [hnb]
  have hhβ : h ≤ β := by omega
  have hbotv : ofLF bot < 2 ^ h := lt_of_lt_of_le (A_ofLF_lt bot) (A_two_pow_le hbot)
  have htopv : ofLF top < 2 ^ h := lt_of_lt_of_le (A_ofLF_lt top) (A_two_pow_le htop)
  have h64 : (2:ℕ) ^ h ≤ 2 ^ 64 := A_two_pow_le (by omega)
  have hβ64 : (2:ℕ) ^ β ≤ 2 ^ 64 := A_two_pow_le (by omega)
  have hfullh_v : 2 ^ h - 1 < 2 ^ 64 := by have := Nat.one_le_two_pow (n := h); omega
  have hfullb_v : 2 ^ β - 1 < 2 ^ 64 := by have := Nat.one_le_two_pow (n := β); omega
  have hgeh_v : 2 ^ β - 2 ^ (h - 1) < 2 ^ 64 := by have := Nat.one_le_two_pow (n := h - 1); omega
  have hpos_v : 2 ^ (β - 1) < 2 ^ 64 := lt_of_lt_of_le (Nat.pow_lt_pow_right (by norm_num) (by omega)) hβ64
  have hehm_v : 2 ^ β - 2 ^ h < 2 ^ 64 := by have := Nat.one_le_two_pow (n := h); omega
  -- the masks
  have l_one : ∀ i < L, lane i one = 1 := fun i hi => A_lane_rep (by norm_num) hi
  have l_fullh : ∀ i < L, lane i fullh = 2 ^ h - 1 := fun i hi => A_lane_rep hfullh_v hi
  have l_fullb : ∀ i < L, lane i fullb = 2 ^ β - 1 := fun i hi => A_lane_rep hfullb_v hi
  have l_geh : ∀ i < L, lane i geh = 2 ^ β - 2 ^ (h - 1) := fun i hi => A_lane_rep hgeh_v hi
  have hfbj : lane j fullb < 2 ^ 32 := by
    rw [l_fullb j hj]; exact A_mask_lt (k := 32) (by omega)
  have hm3 : ∀ i < L, lane i fullh < 2 ^ (64 - 3 * h) := fun i hi => by
    rw [l_fullh i hi]; exact A_mask_lt (by omega)
  have hm2 : ∀ i < L, lane i fullh < 2 ^ (64 - 2 * h) := fun i hi => by
    rw [l_fullh i hi]; exact A_mask_lt (by omega)
  have hm1 : ∀ i < L, lane i fullh < 2 ^ (64 - h) := fun i hi => by
    rw [l_fullh i hi]; exact A_mask_lt (by omega)
  have hmnt : lane j fullh < 2 ^ (64 - nt) := by rw [l_fullh j hj]; exact A_mask_lt (by omega)
  have hmnb : lane j fullh < 2 ^ (64 - nb) := by rw [l_fullh j hj]; exact A_mask_lt (by omega)
  -- the inputs
  have l_xs : ∀ i < L, lane i xs = revLanesL 1 h ((lane i keys >>> (3 * h)) &&& (2 ^ h - 1)) := by
    intro i hi
    show lane i (revLanesL L h ((keys >>> (3 * h)) &&& fullh)) = _
    rw [A_lane_revLanesL hi (by omega), lane_shiftRight_land (k := 3 * h) i keys fullh (hm3 i hi), l_fullh i hi]
  have l_ys : ∀ i < L, lane i ys = revLanesL 1 h ((lane i keys >>> (2 * h)) &&& (2 ^ h - 1)) := by
    intro i hi
    show lane i (revLanesL L h ((keys >>> (2 * h)) &&& fullh)) = _
    rw [A_lane_revLanesL hi (by omega), lane_shiftRight_land (k := 2 * h) i keys fullh (hm2 i hi), l_fullh i hi]
  have l_dxs : ∀ i < L, lane i dxs = revLanesL 1 h ((lane i keys >>> h) &&& (2 ^ h - 1)) := by
    intro i hi
    show lane i (revLanesL L h ((keys >>> h) &&& fullh)) = _
    rw [A_lane_revLanesL hi (by omega), lane_shiftRight_land (k := h) i keys fullh (hm1 i hi), l_fullh i hi]
  have l_dys : ∀ i < L, lane i dys = revLanesL 1 h (lane i keys &&& (2 ^ h - 1)) := by
    intro i hi
    show lane i (revLanesL L h (keys &&& fullh)) = _
    rw [A_lane_revLanesL hi (by omega), lane_land, l_fullh i hi]
  have b_rev : ∀ z, ∀ i < L, lane i (revLanesL L h z) < 2 ^ h := fun z i hi => by
    rw [A_lane_revLanesL hi (by omega)]; exact A_revLanesL_one_lt (by omega) _
  have b_dxs : ∀ i < L, lane i dxs < 2 ^ h := b_rev _
  have b_dys : ∀ i < L, lane i dys < 2 ^ h := b_rev _
  have b_ys : ∀ i < L, lane i ys < 2 ^ h := b_rev _
  -- region R1
  have l_r1 : ∀ i < L, A_l3 i r1 = region1L (h - 1) (2 ^ h - 1) 1 (lane i xs) bot (lane i dxs) 0 0 0 := by
    intro i hi
    show A_l3 i (region1L (h - 1) fullh one xs bot dxs 0 0 0) = _
    rw [A_lane_region1L (w := h) (hm1 := h - 1) (by omega) (by omega) l_fullh (fun i hi => (l_one i hi).le) bot dxs 0 0 0
      (by omega) b_dxs i hi, l_fullh i hi, l_one i hi, A_lane_zero]
  have b_r1 : ∀ i < L, lane i r1.2.1 < 2 ^ bot.length ∧ lane i r1.2.2 < 2 ^ bot.length := by
    intro i hi
    have hb := A_region1L_bound (hm1 := h - 1) (fullh := 2 ^ h - 1) (xs := lane i xs) (le_refl 1) bot (lane i dxs)
      0 0 0 (by norm_num) (by norm_num)
    rw [Nat.zero_add, ← l_r1 i hi] at hb
    exact hb
  -- the columns
  have l_ysAll : ∀ i < L, lane i ysAll = lane i ys ||| (ofLF bot <<< h) := by
    intro i hi
    show lane i (ys ||| (laneRepL (ofLF bot) L <<< h)) = _
    rw [lane_lor, A_lane_shiftLeft (k := h) (w := h) (by omega)
      (fun i hi => by rw [A_lane_rep (lt_of_lt_of_le hbotv h64) hi]; exact hbotv) hi,
      A_lane_rep (lt_of_lt_of_le hbotv h64) hi]
  have b_ysAll : ∀ i < L, lane i ysAll < 2 ^ β := by
    intro i hi
    rw [l_ysAll i hi]
    have e : bot.length + h = β := by omega
    exact Nat.or_lt_two_pow (lt_of_lt_of_le (b_ys i hi) (A_two_pow_le hhβ)) (e ▸ A_shiftLeft_lt (A_ofLF_lt bot))
  have l_H0 : ∀ i < L, lane i (dys ||| (r1.2.2 <<< h)) = lane i dys ||| (lane i r1.2.2 <<< h) := by
    intro i hi
    rw [lane_lor, A_lane_shiftLeft (k := h) (w := bot.length) (by omega) (fun i hi => (b_r1 i hi).2) hi]
  have b_H0 : ∀ i < L, lane i (dys ||| (r1.2.2 <<< h)) < 2 ^ β := by
    intro i hi
    rw [l_H0 i hi]
    have e : bot.length + h = β := by omega
    exact Nat.or_lt_two_pow (lt_of_lt_of_le (b_dys i hi) (A_two_pow_le hhβ)) (e ▸ A_shiftLeft_lt (b_r1 i hi).2)
  -- region R2
  have l_r2 : ∀ i < L, A_lr i r2 =
      region2L (β - 1) (2 ^ β - 1) 1 (lane i ysAll) top (lane i dys ||| (lane i r1.2.2 <<< h)) 0 [] 0 := by
    intro i hi
    show A_lr i (region2L (β - 1) fullb one ysAll top (dys ||| (r1.2.2 <<< h)) 0 [] 0) = _
    rw [A_lane_region2L (w := β) (bm1 := β - 1) (by omega) (by omega) l_fullb (fun i hi => (l_one i hi).le) top _ 0 []
      0 (by omega) b_H0 i hi, l_fullb i hi, l_one i hi, A_lane_zero, l_H0 i hi, List.map_nil]
  have b_r2 : ∀ i < L, lane i r2.2.2 < 2 ^ top.length := by
    intro i hi
    have hb := A_region2L_bound (bm1 := β - 1) (fullb := 2 ^ β - 1) (ys := lane i ysAll) (le_refl 1) top
      (lane i dys ||| (lane i r1.2.2 <<< h)) 0 [] 0 (by norm_num)
    rw [Nat.zero_add, ← l_r2 i hi] at hb
    exact hb
  -- lane j
  have e_xs : lane j xs = xs1 := l_xs j hj
  have e_ys : lane j ys = ys1 := l_ys j hj
  have e_dxs : lane j dxs = dxs1 := l_dxs j hj
  have e_dys : lane j dys = dys1 := l_dys j hj
  have e_r1 : A_l3 j r1 = r11 := by rw [l_r1 j hj, e_xs, e_dxs]
  have e_r1_1 : lane j r1.1 = r11.1 := congrArg (fun p => p.1) e_r1
  have e_r1_21 : lane j r1.2.1 = r11.2.1 := congrArg (fun p => p.2.1) e_r1
  have e_r1_22 : lane j r1.2.2 = r11.2.2 := congrArg (fun p => p.2.2) e_r1
  have e_ysAll : lane j ysAll = ysAll1 := by rw [l_ysAll j hj, e_ys]
  have e_r2 : A_lr j r2 = r21 := by rw [l_r2 j hj, e_ysAll, e_dys, e_r1_22]
  have e_r2_1 : lane j r2.1 = r21.1 := congrArg (fun p => p.1) e_r2
  have e_rows : r2.2.1.map (A_lp j) = r21.2.1 := congrArg (fun p => p.2.1) e_r2
  have e_r2_22 : lane j r2.2.2 = r21.2.2 := congrArg (fun p => p.2.2) e_r2
  have e_t : A_lp j t = t1 := by
    show A_lp j (traceRowsL fullb geh one r2.2.1 one (laneRepL (2 ^ (β - 1)) L)) = _
    rw [A_lane_traceRowsL hfbj, l_fullb j hj, l_geh j hj, l_one j hj, A_lane_rep hpos_v hj, e_rows]
  have e_t1 : lane j t.1 = t1.1 := congrArg (fun p => p.1) e_t
  have e_t2 : lane j t.2 = t1.2 := congrArg (fun p => p.2) e_t
  have e_eh : lane j eh = eh1 := by
    show lane j ((((r1.2.1 <<< h) ^^^ fullb) ||| (r1.2.2 <<< h)) &&& laneRepL (2 ^ β - 2 ^ h) L) = _
    rw [lane_land, lane_lor, lane_xor,
      A_lane_shiftLeft (k := h) (w := bot.length) (by omega) (fun i hi => (b_r1 i hi).1) hj,
      A_lane_shiftLeft (k := h) (w := bot.length) (by omega) (fun i hi => (b_r1 i hi).2) hj,
      l_fullb j hj, A_lane_rep hehm_v hj, e_r1_21, e_r1_22]
  have e_bad : lane j bad = bad1 := by
    show lane j (fillDownL fullb (eh &&& fillDownL fullb t.2) &&& one) = _
    rw [lane_land, A_lane_fillDownL hfbj, lane_land, A_lane_fillDownL hfbj, l_fullb j hj, l_one j hj, e_eh,
      e_t2]
  have e_atleast : lane j atleast = atleast1 := by
    show lane j (fillDownL fullb (t.2 &&& geh) &&& one) = _
    rw [lane_land, A_lane_fillDownL hfbj, lane_land, l_fullb j hj, l_one j hj, l_geh j hj, e_t2]
  have e_acc : lane j acc = acc1 := by
    show lane j ((t.1 &&& atleast) &&& (bad ^^^ one)) = _
    rw [lane_land, lane_land, lane_xor, e_t1, e_atleast, e_bad, l_one j hj]
  have e_x' : lane j x' = x'1 := by
    show lane j (((xs ||| (laneRepL (ofLF top) L <<< h)) >>> nt) &&& fullh) = _
    rw [lane_shiftRight_land (k := nt) j _ fullh hmnt, lane_lor,
      A_lane_shiftLeft (k := h) (w := h) (by omega)
        (fun i hi => by rw [A_lane_rep (lt_of_lt_of_le htopv h64) hi]; exact htopv) hj,
      A_lane_rep (lt_of_lt_of_le htopv h64) hj, l_fullh j hj, e_xs]
  have e_y' : lane j y' = y'1 := by
    show lane j ((ysAll >>> nb) &&& fullh) = _
    rw [lane_shiftRight_land (k := nb) j _ fullh hmnb, l_fullh j hj, e_ysAll]
  have e_dx' : lane j dx' = dx'1 := by
    show lane j (((r1.1 ||| (r2.2.2 <<< h)) >>> nt) &&& fullh) = _
    rw [lane_shiftRight_land (k := nt) j _ fullh hmnt, lane_lor,
      A_lane_shiftLeft (k := h) (w := top.length) (by omega) (fun i hi => b_r2 i hi) hj, l_fullh j hj, e_r1_1,
      e_r2_22]
  have e_dy' : lane j dy' = dy'1 := by
    show lane j ((r2.1 >>> nb) &&& fullh) = _
    rw [lane_shiftRight_land (k := nb) j _ fullh hmnb, l_fullh j hj, e_r2_1]
  have e_flm : lane j flm = flm1 := by
    show lane j (spreadL fullh (x' &&& one)) = _
    rw [A_lane_spreadL (x := x' &&& one) hj
      (fun i hi => by rw [lane_land, l_one i hi]; exact lt_of_le_of_lt Nat.and_le_right (by norm_num)),
      lane_land, l_fullh j hj, l_one j hj, e_x']
  refine ⟨e_acc, ?_⟩
  show lane j ((((revLanesL L h (x' ^^^ flm) <<< (3 * h)) ||| (revLanesL L h (y' ^^^ flm) <<< (2 * h))) |||
    (revLanesL L h dx' <<< h)) ||| revLanesL L h dy') = _
  rw [lane_lor, lane_lor, lane_lor,
    A_lane_shiftLeft (k := 3 * h) (w := h) (by omega) (b_rev _) hj,
    A_lane_shiftLeft (k := 2 * h) (w := h) (by omega) (b_rev _) hj,
    A_lane_shiftLeft (k := h) (w := h) (by omega) (b_rev _) hj,
    A_lane_revLanesL hj (by omega), A_lane_revLanesL hj (by omega), A_lane_revLanesL hj (by omega),
    A_lane_revLanesL hj (by omega), lane_xor, lane_xor, e_x', e_y', e_dx', e_dy', e_flm]

end CS31a
