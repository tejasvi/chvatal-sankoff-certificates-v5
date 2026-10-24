import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1222 = cert_data/n13/h13c.vec.part1222, entries 117885108224 .. 117981577215, chunks 28106 .. 28128
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1222 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1222" 385875968 16777216

end CS31aData.N13
