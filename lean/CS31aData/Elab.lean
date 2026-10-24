import Lean
import CS31aCert.Bytes

/-!
# `nat_of_file%`: certificate bytes as a natural-number literal

`nat_of_file% "path" len` elaborates to the raw literal `n : ℕ` whose little-endian base-256 digits are the first
`len` bytes of the file (an error if the file is shorter). It runs at elaboration time and is not part of any proof:
the kernel only sees the literal. PROVENANCE.md records the sha256 of every input file.
-/

open Lean Elab Term

namespace CS31aData

export CS31aCert (natOfBytes)

syntax (name := natOfFile) "nat_of_file% " str num : term

@[term_elab natOfFile] def elabNatOfFile : TermElab := fun stx _ => do
  match stx with
  | `(nat_of_file% $p:str $l:num) =>
    let bytes ← IO.FS.readBinFile p.getString
    let len := l.getNat
    unless len ≤ bytes.size do throwError "nat_of_file%: file {p.getString} has {bytes.size} < {len} bytes"
    return mkRawNatLit (natOfBytes bytes 0 len)
  | _ => throwUnsupportedSyntax


syntax (name := chunksOfFile) "chunks_of_file% " str num num : term

/-- `chunks_of_file% "path" len chunk`: the first `len` bytes of the file as a list of
`(literal, byte length)` pairs of at most `chunk` bytes each. -/
@[term_elab chunksOfFile] def elabChunksOfFile : TermElab := fun stx _ => do
  match stx with
  | `(chunks_of_file% $p:str $l:num $c:num) =>
    let bytes ← IO.FS.readBinFile p.getString
    let len := l.getNat
    let chunk := c.getNat
    unless len ≤ bytes.size ∧ 0 < chunk do throwError "chunks_of_file%: file {p.getString} too short or bad chunk"
    let nchunks := (len + chunk - 1) / chunk
    let pairs := (List.range nchunks).map fun i =>
      let off := i * chunk
      let sz := min chunk (len - off)
      mkApp4 (mkConst ``Prod.mk [levelZero, levelZero]) (mkConst ``Nat) (mkConst ``Nat)
        (mkRawNatLit (natOfBytes bytes off sz)) (mkRawNatLit sz)
    let ty := mkApp2 (mkConst ``Prod [levelZero, levelZero]) (mkConst ``Nat) (mkConst ``Nat)
    return pairs.foldr (fun e acc => mkApp3 (mkConst ``List.cons [levelZero]) ty e acc)
      (mkApp (mkConst ``List.nil [levelZero]) ty)
  | _ => throwUnsupportedSyntax

end CS31aData
