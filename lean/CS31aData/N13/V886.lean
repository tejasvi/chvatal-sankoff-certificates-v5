import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 886 = cert_data/n13/h13c.vec.part0886, entries 85471526912 .. 85567995903, chunks 20378 .. 20400
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v886 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0886" 385875968 16777216

end CS31aData.N13
