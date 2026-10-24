import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 844 = cert_data/n13/h13c.vec.part0844, entries 81419829248 .. 81516298239, chunks 19412 .. 19434
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v844 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0844" 385875968 16777216

end CS31aData.N13
