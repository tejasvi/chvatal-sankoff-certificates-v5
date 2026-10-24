import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1557 = cert_data/n13/h13c.vec.part1557, entries 150202220544 .. 150298689535, chunks 35811 .. 35833
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1557 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1557" 385875968 16777216

end CS31aData.N13
