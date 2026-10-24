import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1183 = cert_data/n13/h13c.vec.part1183, entries 114122817536 .. 114219286527, chunks 27209 .. 27231
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1183 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1183" 385875968 16777216

end CS31aData.N13
