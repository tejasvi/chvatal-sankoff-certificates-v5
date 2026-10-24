import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1225 = cert_data/n13/h13c.vec.part1225, entries 118174515200 .. 118270984191, chunks 28175 .. 28197
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1225 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1225" 385875968 16777216

end CS31aData.N13
