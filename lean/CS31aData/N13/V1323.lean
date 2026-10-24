import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1323 = cert_data/n13/h13c.vec.part1323, entries 127628476416 .. 127724945407, chunks 30429 .. 30451
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1323 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1323" 385875968 16777216

end CS31aData.N13
