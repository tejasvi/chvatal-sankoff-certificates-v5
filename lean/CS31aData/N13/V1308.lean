import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1308 = cert_data/n13/h13c.vec.part1308, entries 126181441536 .. 126277910527, chunks 30084 .. 30106
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1308 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1308" 385875968 16777216

end CS31aData.N13
