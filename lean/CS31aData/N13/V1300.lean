import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1300 = cert_data/n13/h13c.vec.part1300, entries 125409689600 .. 125506158591, chunks 29900 .. 29922
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1300 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1300" 385875968 16777216

end CS31aData.N13
