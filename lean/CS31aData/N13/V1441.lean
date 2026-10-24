import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1441 = cert_data/n13/h13c.vec.part1441, entries 139011817472 .. 139108286463, chunks 33143 .. 33165
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1441 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1441" 385875968 16777216

end CS31aData.N13
