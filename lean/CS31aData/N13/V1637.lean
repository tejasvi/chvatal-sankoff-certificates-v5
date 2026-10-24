import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1637 = cert_data/n13/h13c.vec.part1637, entries 157919739904 .. 158016208895, chunks 37651 .. 37673
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1637 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1637" 385875968 16777216

end CS31aData.N13
