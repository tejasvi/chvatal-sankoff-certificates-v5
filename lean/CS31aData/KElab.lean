import CS31aCert.KTree
import CS31aData.Elab

/-!
# `ktree_of_files%`: a certificate (keys file, vector file) as a `KTree` term

`ktree_of_files% "keys" "vec" n chunk` reads `n` little-endian `UInt64` codes and `n` doubles and builds the balanced
`KTree` with leaves of `chunk` consecutive entries (the last leaf may be shorter), split keys = first key of the right
part. Elaboration-time only; the kernel sees the term.
-/

open Lean Elab Term

namespace CS31aData

def u64At (b : ByteArray) (i : Nat) : Nat := natOfBytes b (8 * i) 8

partial def mkKTree (kb vb : ByteArray) (lo hi chunk : Nat) : Expr :=
  if hi - lo ≤ chunk then
    mkApp3 (mkConst ``CS31aCert.KTree.leaf) (mkRawNatLit (hi - lo))
      (mkRawNatLit (natOfBytes kb (8 * lo) (8 * (hi - lo)))) (mkRawNatLit (natOfBytes vb (8 * lo) (8 * (hi - lo))))
  else
    let c := (hi - lo + chunk - 1) / chunk
    let mid := lo + (c / 2) * chunk
    mkApp3 (mkConst ``CS31aCert.KTree.node) (mkRawNatLit (u64At kb mid))
      (mkKTree kb vb lo mid chunk) (mkKTree kb vb mid hi chunk)

syntax (name := ktreeOfFiles) "ktree_of_files% " str str num num : term

@[term_elab ktreeOfFiles] def elabKTreeOfFiles : TermElab := fun stx _ => do
  match stx with
  | `(ktree_of_files% $pk:str $pv:str $n:num $c:num) =>
    let kb ← IO.FS.readBinFile pk.getString
    let vb ← IO.FS.readBinFile pv.getString
    let n := n.getNat
    unless 8 * n ≤ kb.size ∧ 8 * n ≤ vb.size do throwError "ktree_of_files%: files too short"
    return mkKTree kb vb 0 n c.getNat
  | _ => throwUnsupportedSyntax

end CS31aData
