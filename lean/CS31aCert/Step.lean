/-!
# The transition of Lueker's automaton `M_h` on packed state codes (core Lean only)

A state `(x, y, d_x, d_y)` is the code `x·2^(3h) + y·2^(2h) + d_x·2^h + d_y`; position `r` (1-indexed) of each
`h`-bit field is bit `h - r` (oldest symbol = most significant bit).

The window table is computed in increment form. A *line update* computes one new column (or row) of the table
from the increments of the previous one: with `cross_0 = 0`,
`cross_p = if syms_p = sym then ¬inc_p else (cross_{p-1} ∧ ¬inc_p)` and
`newinc_p = if cross_p ≠ cross_{p-1} then cross_p else inc_p` (the LCS recurrence for 0/1 increments).
Region R1 = rows `1..h` of the new columns, region R2 = the new rows (all columns). The canonical traceback runs on
the increments. `CS31a.Fast` proves `stepCode h (encode q) c l = (stepRed q c l).map encode`.
-/

namespace CS31aCert

/-- The bits of `n` at positions `k-1, …, 0` (most significant first). -/
def bitsMSB (n : Nat) : Nat → List Bool
  | 0 => []
  | k + 1 => n.testBit k :: bitsMSB n k

/-- The number with the given bits (most significant first), appended to `acc`. -/
def ofBitsMSB : List Bool → Nat → Nat
  | [], acc => acc
  | b :: bs, acc => ofBitsMSB bs (2 * acc + if b then 1 else 0)

/-- The two strings of `T_{c,l}`. -/
def topStr (c : Bool) (l : Int) : List Bool :=
  if 0 ≤ l then List.replicate l.toNat (!c) ++ [c] else [c]

def botStr (c : Bool) (l : Int) : List Bool :=
  if 0 ≤ l then [c] else List.replicate l.natAbs (!c) ++ [c]

/-- One line update in increment form: `sym` is the symbol of the new line, `syms` the symbols of the other string
at positions `1..n`, `inc` the increments of the previous line at positions `1..n`, `prev` the cross increment at
the previous position. Returns (increments of the new line, cross increments). -/
def lineUpd (sym : Bool) : List Bool → List Bool → Bool → List Bool × List Bool
  | s :: ss, i :: is, prev =>
    let cr := if s == sym then !i else (prev && !i)
    let ni := if cr != prev then cr else i
    let r := lineUpd sym ss is cr
    (ni :: r.1, cr :: r.2)
  | _, _, _ => ([], [])

/-- Region R1 (rows `1..h` of the new columns `h+1..β`, symbols `bs`). Input: the symbols `xs = a_1..a_h` and the
vertical increments `V` of the previous column. Output: the vertical increments of column `β` and, for each new
column `s`, the pair (vertical, horizontal) increment at row `h`. -/
def region1 (xs : List Bool) : List Bool → List Bool → List Bool × List (Bool × Bool)
  | V, [] => (V, [])
  | V, b :: bs =>
    let p := lineUpd b xs V false
    let r := region1 xs p.1 bs
    (r.1, (p.1.getLastD false, p.2.getLastD false) :: r.2)

/-- Region R2 (the new rows `h+1..α`, symbols `as`, all columns `1..β`). Input: the symbols `ys = b_1..b_β` and the
horizontal increments `H` of row `h`. Output: the horizontal increments of row `α` and, for each new row, its
(vertical, horizontal) increment lines. -/
def region2 (ys : List Bool) : List Bool → List Bool → List Bool × List (List Bool × List Bool)
  | H, [] => (H, [])
  | H, a :: as =>
    let p := lineUpd a ys H false
    let r := region2 ys p.1 as
    (r.1, (p.2, p.1) :: r.2)

/-- The canonical traceback on increments (`vert r s = (W(r,s) ≠ W(r-1,s))`, `horiz r s = (W(r,s) ≠ W(r,s-1))`),
with fuel. -/
def traceInc (h : Nat) (vert horiz : Nat → Nat → Bool) : Nat → Nat → Nat → Bool
  | 0, _, _ => false
  | fuel + 1, r, s =>
    if r < h ∨ s < h then false
    else if r = h ∧ s = h then true
    else if !vert r s then traceInc h vert horiz fuel (r - 1) s
    else if !horiz r s then traceInc h vert horiz fuel r (s - 1)
    else traceInc h vert horiz fuel (r - 1) (s - 1)

/-- The result of a transition on unpacked fields: `some (x', y', d_x', d_y')` (before the complement reduction). -/
def stepLists (h : Nat) (xs ys dxs dys : List Bool) (c : Bool) (l : Int) :
    Option (List Bool × List Bool × List Bool × List Bool) :=
  let top := topStr c l
  let bot := botStr c l
  let α := h + top.length
  let β := h + bot.length
  let r1 := region1 xs dxs bot
  let ysAll := ys ++ bot
  let r2 := region2 ysAll (dys ++ r1.2.map Prod.snd) top
  let vert : Nat → Nat → Bool := fun r s =>
    if r ≤ h then (r1.2.getD (s - h - 1) (false, false)).1
    else ((r2.2.getD (r - h - 1) ([], [])).1).getD (s - 1) false
  let horiz : Nat → Nat → Bool := fun r s =>
    if r ≤ h then (r1.2.getD (s - h - 1) (false, false)).2
    else ((r2.2.getD (r - h - 1) ([], [])).2).getD (s - 1) false
  if traceInc h vert horiz (α + β + 1) α β then
    some ((xs ++ top).drop top.length, ysAll.drop bot.length,
          (r1.1 ++ r2.2.map (fun p => p.1.getLastD false)).drop top.length, r2.1.drop bot.length)
  else none

/-- The fields of a code. -/
def fieldX (h k : Nat) : Nat := (k >>> (3 * h)) % 2 ^ h
def fieldY (h k : Nat) : Nat := (k >>> (2 * h)) % 2 ^ h
def fieldDX (h k : Nat) : Nat := (k >>> h) % 2 ^ h
def fieldDY (h k : Nat) : Nat := k % 2 ^ h

/-- Packing four `h`-bit fields. -/
def packCode (h x y dx dy : Nat) : Nat := ((x * 2 ^ h + y) * 2 ^ h + dx) * 2 ^ h + dy

/-- The reduced transition `δ_red` on codes: `none` if the input `T_{c,l}` is rejected. -/
def stepCode (h k : Nat) (c : Bool) (l : Int) : Option Nat :=
  match stepLists h (bitsMSB (fieldX h k) h) (bitsMSB (fieldY h k) h) (bitsMSB (fieldDX h k) h)
      (bitsMSB (fieldDY h k) h) c l with
  | none => none
  | some (x', y', dx', dy') =>
    let flip := x'.headD false
    let x'' := if flip then x'.map (!·) else x'
    let y'' := if flip then y'.map (!·) else y'
    some (packCode h (ofBitsMSB x'' 0) (ofBitsMSB y'' 0) (ofBitsMSB dx' 0) (ofBitsMSB dy' 0))

/-- The start state `(0^h, 0^h, 1^h, 1^h)`. -/
def startCode (h : Nat) : Nat := packCode h 0 0 (2 ^ h - 1) (2 ^ h - 1)

/-- The inputs `(c, l)`, `c ∈ {0,1}`, `|l| ≤ h - 1`, in a fixed order. -/
def inputList (h : Nat) : List (Bool × Int) :=
  [false, true].flatMap fun c => (List.range (2 * h - 1)).map fun (i : Nat) => (c, (i : Int) - ((h : Int) - 1))

end CS31aCert
