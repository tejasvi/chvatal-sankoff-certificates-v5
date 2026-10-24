import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1228 = cert_data/n13/h13c.vec.part1228, entries 118463922176 .. 118560391167, chunks 28244 .. 28266
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1228 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1228" 385875968 16777216

end CS31aData.N13
