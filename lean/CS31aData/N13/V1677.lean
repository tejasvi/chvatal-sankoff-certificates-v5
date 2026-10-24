import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1677 = cert_data/n13/h13c.vec.part1677, entries 161778499584 .. 161874968575, chunks 38571 .. 38593
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1677 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1677" 385875968 16777216

end CS31aData.N13
