import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1095 = cert_data/n13/h13c.vec.part1095, entries 105633546240 .. 105730015231, chunks 25185 .. 25207
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1095 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1095" 385875968 16777216

end CS31aData.N13
