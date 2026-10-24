import CS31aCert.Row

/-!
# Certificate data as a kernel term (core Lean only)

A `KTree` stores the entries `(k, u)` (state code, bits of `v(k)`) in leaves of up to a few dozen consecutive
entries, each leaf as two literals (`keys`, `vals`: entry `i` at bits `64 i … 64 i + 63`). Inner nodes carry a split
key (keys `< split` go left). The kernel checker evaluates `rowOK` on every entry of a subtree with the lookup
`KTree.find` of the whole tree. Nothing about the order of the keys is assumed by the soundness proof:
`rowOK` re-checks `find k = some u` for every entry.
-/

namespace CS31aCert

inductive KTree where
  | leaf (cnt keys vals : Nat)
  | node (split : Nat) (l r : KTree)

/-- Linear scan of a leaf for the code `t`. -/
def leafFind (t : Nat) : Nat → Nat → Nat → Option Nat
  | 0, _, _ => none
  | cnt + 1, keys, vals =>
    if Nat.beq (keys % 18446744073709551616) t then some (vals % 18446744073709551616)
    else leafFind t cnt (keys >>> 64) (vals >>> 64)

/-- Lookup of the value bits of a code. -/
def KTree.find : KTree → Nat → Option Nat
  | .leaf cnt keys vals, t => leafFind t cnt keys vals
  | .node s l r, t => if Nat.blt t s then l.find t else r.find t

/-- `p` holds for all entries of a leaf. -/
def leafAll (p : Nat → Nat → Bool) : Nat → Nat → Nat → Bool
  | 0, _, _ => true
  | cnt + 1, keys, vals =>
    p (keys % 18446744073709551616) (vals % 18446744073709551616) && leafAll p cnt (keys >>> 64) (vals >>> 64)

/-- `p` holds for all entries. -/
def KTree.all (p : Nat → Nat → Bool) : KTree → Bool
  | .leaf cnt keys vals => leafAll p cnt keys vals
  | .node _ l r => l.all p && r.all p

/-- The subtree at a path (`false` = left); a leaf is its own subtree. -/
def KTree.sub : KTree → List Bool → KTree
  | t, [] => t
  | .leaf c k v, _ :: _ => .leaf c k v
  | .node _ l r, b :: bs => (if b then r else l).sub bs

/-- The kernel check of one shard: every entry of `sub` passes `rowOK` with the lookup of the whole tree `t`. -/
def checkK (h : Nat) (t : KTree) (wt : List Nat) (lam : Nat) (sub : KTree) : Bool :=
  sub.all fun k u => rowOK h t.find wt lam k u

end CS31aCert
