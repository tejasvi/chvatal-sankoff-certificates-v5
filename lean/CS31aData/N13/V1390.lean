import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1390 = cert_data/n13/h13c.vec.part1390, entries 134091898880 .. 134188367871, chunks 31970 .. 31992
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1390 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1390" 385875968 16777216

end CS31aData.N13
