import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1084 = cert_data/n13/h13c.vec.part1084, entries 104572387328 .. 104668856319, chunks 24932 .. 24954
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1084 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1084" 385875968 16777216

end CS31aData.N13
