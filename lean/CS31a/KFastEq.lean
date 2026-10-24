import CS31a.KStepEq
import CS31aCert.KFast

/-!
# `checkKF = checkKK`

Each recursor-based function of CS31aCert/KFast.lean equals its structural counterpart (induction on the recursion
argument), hence the recursor-based shard check `checkKF` equals `checkKK` and, for `h ≥ 1`, `checkK`.
-/

namespace CS31a

open CS31aCert

theorem blt_dec (a b : ℕ) : Nat.blt a b = decide (a < b) := Bool.eq_iff_iff.mpr (by simp [Nat.blt_eq])
theorem beq_dec (a b : ℕ) : Nat.beq a b = decide (a = b) := Bool.eq_iff_iff.mpr (by simp [Nat.beq_eq])
theorem ble_dec (a b : ℕ) : Nat.ble a b = decide (a ≤ b) := Bool.eq_iff_iff.mpr (by simp [Nat.ble_eq])

theorem leafFindF_eq (t : ℕ) : ∀ cnt keys vals, leafFindF t cnt keys vals = leafFind t cnt keys vals := by
  intro cnt
  induction cnt with
  | zero => intro keys vals; rfl
  | succ cnt ih =>
    intro keys vals
    show cond (Nat.beq (keys % 18446744073709551616) t) (some (vals % 18446744073709551616))
      (leafFindF t cnt (keys >>> 64) (vals >>> 64)) = leafFind t (cnt + 1) keys vals
    rw [ih, leafFind]; cases Nat.beq (keys % 18446744073709551616) t <;> rfl

theorem findF_eq (T : KTree) (t : ℕ) : T.findF t = T.find t := by
  induction T with
  | leaf cnt keys vals => exact leafFindF_eq t cnt keys vals
  | node s l r ihl ihr =>
    show cond (Nat.blt t s) (l.findF t) (r.findF t) = (KTree.node s l r).find t
    rw [ihl, ihr, KTree.find]; cases Nat.blt t s <;> rfl

theorem leafAllF_eq (p : ℕ → ℕ → Bool) : ∀ cnt keys vals, leafAllF p cnt keys vals = leafAll p cnt keys vals := by
  intro cnt
  induction cnt with
  | zero => intro keys vals; rfl
  | succ cnt ih =>
    intro keys vals
    show (p (keys % 18446744073709551616) (vals % 18446744073709551616) &&
      leafAllF p cnt (keys >>> 64) (vals >>> 64)) = leafAll p (cnt + 1) keys vals
    rw [ih, leafAll]

theorem allF_eq (p : ℕ → ℕ → Bool) (T : KTree) : T.allF p = T.all p := by
  induction T with
  | leaf cnt keys vals => exact leafAllF_eq p cnt keys vals
  | node s l r ihl ihr =>
    show (l.allF p && r.allF p) = (KTree.node s l r).all p
    rw [ihl, ihr, KTree.all]

theorem revBitsF_eq : ∀ n x acc, revBitsF n x acc = revBits n x acc := by
  intro n
  induction n with
  | zero => intro x acc; rfl
  | succ n ih =>
    intro x acc
    show revBitsF n (x >>> 1) (2 * acc + x % 2) = revBits (n + 1) x acc
    rw [ih, revBits]

theorem ofLF_eq : ∀ L : List Bool, ofLF L = ofL L
  | [] => rfl
  | b :: L => by
    show cond b 1 0 + 2 * ofLF L = ofL (b :: L)
    rw [ofLF_eq L, ofL_cons]; cases b <;> rfl

theorem lengthF_eq {α : Type} : ∀ L : List α, lengthF L = L.length
  | [] => rfl
  | _ :: L => by show lengthF L + 1 = _; rw [lengthF_eq L, List.length_cons]

theorem region1F_eq (hm1 full xs : ℕ) : ∀ (bs : List Bool) V j av ah,
    region1F hm1 full xs bs V j av ah = region1M hm1 full xs V bs j av ah := by
  intro bs
  induction bs with
  | nil => intro V j av ah; rfl
  | cons b bs ih =>
    intro V j av ah
    show region1F hm1 full xs bs (lineUpdM full b xs V).1 (j + 1)
        (av ||| (((lineUpdM full b xs V).1 >>> hm1) % 2) <<< j)
        (ah ||| (((lineUpdM full b xs V).2 >>> hm1) % 2) <<< j) = region1M hm1 full xs V (b :: bs) j av ah
    rw [ih, region1M]

theorem region2F_eq (n full ys : ℕ) : ∀ (as : List Bool) H j sh av ah ab,
    region2F n full ys as H j sh av ah ab = region2M n full ys H as j sh av ah ab := by
  intro as
  induction as with
  | nil => intro H j sh av ah ab; rfl
  | cons a as ih =>
    intro H j sh av ah ab
    show region2F n full ys as (lineUpdM full a ys H).1 (j + 1) (sh + n) (av ||| ((lineUpdM full a ys H).2 <<< sh))
        (ah ||| ((lineUpdM full a ys H).1 <<< sh)) (ab ||| ((((lineUpdM full a ys H).2 >>> (n - 1)) % 2) <<< j)) =
      region2M n full ys H (a :: as) j sh av ah ab
    rw [ih, region2M]

theorem traceIncF_eq (h : ℕ) (vert horiz : ℕ → ℕ → Bool) :
    ∀ fuel r s, traceIncF h vert horiz fuel r s = traceInc h vert horiz fuel r s := by
  intro fuel
  induction fuel with
  | zero => intro r s; rfl
  | succ fuel ih =>
    intro r s
    show cond (Nat.blt r h || Nat.blt s h) false
        (cond (Nat.beq r h && Nat.beq s h) true
          (cond (!vert r s) (traceIncF h vert horiz fuel (r - 1) s)
            (cond (!horiz r s) (traceIncF h vert horiz fuel r (s - 1))
              (traceIncF h vert horiz fuel (r - 1) (s - 1))))) = traceInc h vert horiz (fuel + 1) r s
    rw [ih, ih, ih, traceInc]
    simp only [blt_dec, beq_dec, Bool.cond_eq_ite, Bool.or_eq_true, Bool.and_eq_true, decide_eq_true_eq]

theorem kstepF_eq (h k : ℕ) (c : Bool) (l : ℤ) : kstepF h k c l = kstep h k c l := by
  unfold kstepF kstep
  simp only [revBitsF_eq, ofLF_eq, lengthF_eq, region1F_eq, region2F_eq, traceIncF_eq, ble_dec, beq_dec,
    Bool.cond_decide, Bool.cond_eq_ite, decide_eq_true_eq]

theorem foldlF_eq {α β : Type} (f : α → β → α) : ∀ (L : List β) (init : α), foldlF f init L = L.foldl f init
  | [], _ => rfl
  | x :: L, init => by show foldlF f (f init x) L = _; rw [foldlF_eq f L, List.foldl_cons]

theorem rowIneqF_eq (lam ui : ℕ) (terms : List (ℕ × ℕ)) : rowIneqF lam ui terms = rowIneq lam ui terms := by
  unfold rowIneqF rowIneq; simp only [foldlF_eq]

theorem rowTermsF_eq (h : ℕ) (find : ℕ → Option ℕ) (wt : List ℕ) (k : ℕ) :
    ∀ ps : List (Bool × ℤ), rowTermsF h find wt k ps = rowTermsK h find wt k ps
  | [] => rfl
  | (c, l) :: ps => by
    show Option.rec (rowTermsF h find wt k ps)
        (fun t => Option.rec none (fun u => Option.rec none (fun r => some ((wt.getD l.natAbs 0, u) :: r))
          (rowTermsF h find wt k ps)) (find t)) (kstepF h k c l) = rowTermsK h find wt k ((c, l) :: ps)
    rw [rowTermsF_eq h find wt k ps, kstepF_eq, rowTermsK]
    cases kstep h k c l with
    | none => rfl
    | some t =>
      dsimp only
      cases find t with
      | none => rfl
      | some u => dsimp only; cases rowTermsK h find wt k ps <;> rfl

theorem rowOKF_eq (h : ℕ) (find : ℕ → Option ℕ) (wt : List ℕ) (lam k u : ℕ) :
    rowOKF h find wt lam k u = rowOKK h find wt lam k u := by
  unfold rowOKF rowOKK
  rw [rowTermsF_eq]
  cases rowTermsK h find wt k (inputList h) with
  | none => rfl
  | some terms => simp only [rowIneqF_eq]

theorem checkKF_eq (h : ℕ) (t : KTree) (wt : List ℕ) (lam : ℕ) (sub : KTree) :
    checkKF h t wt lam sub = checkKK h t wt lam sub := by
  unfold checkKF checkKK
  rw [allF_eq]
  congr 1; funext k u
  rw [show t.findF = t.find from funext (findF_eq t), rowOKF_eq]

/-- Combining shards checked with `checkKF`. -/
theorem checkK_of_shardsKF {h : ℕ} (hh : 1 ≤ h) {t : KTree} {wt : List ℕ} {lam : ℕ} (T : KTree) (d : ℕ)
    (hs : ∀ path ∈ allPaths d, checkKF h t wt lam (T.sub path) = true) : checkK h t wt lam T = true :=
  checkK_of_shardsKK hh T d fun path hp => by rw [← checkKF_eq]; exact hs path hp

end CS31a
