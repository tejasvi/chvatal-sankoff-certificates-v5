import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1360 = cert_data/n13/h13c.vec.part1360, entries 131197829120 .. 131294298111, chunks 31280 .. 31302
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1360 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1360" 385875968 16777216

end CS31aData.N13
