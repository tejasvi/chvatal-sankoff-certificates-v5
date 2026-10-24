import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1675 = cert_data/n13/h13c.vec.part1675, entries 161585561600 .. 161682030591, chunks 38525 .. 38547
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1675 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1675" 385875968 16777216

end CS31aData.N13
