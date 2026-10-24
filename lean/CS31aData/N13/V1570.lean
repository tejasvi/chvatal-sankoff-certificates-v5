import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1570 = cert_data/n13/h13c.vec.part1570, entries 151456317440 .. 151552786431, chunks 36110 .. 36132
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1570 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1570" 385875968 16777216

end CS31aData.N13
