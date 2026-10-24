import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1655 = cert_data/n13/h13c.vec.part1655, entries 159656181760 .. 159752650751, chunks 38065 .. 38087
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1655 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1655" 385875968 16777216

end CS31aData.N13
