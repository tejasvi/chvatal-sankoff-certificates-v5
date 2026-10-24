import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 262 = cert_data/n13/h13c.vec.part0262, entries 25274875904 .. 25371344895, chunks 6026 .. 6048
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v262 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0262" 385875968 16777216

end CS31aData.N13
