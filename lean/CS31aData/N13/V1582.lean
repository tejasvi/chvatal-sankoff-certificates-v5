import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1582 = cert_data/n13/h13c.vec.part1582, entries 152613945344 .. 152710414335, chunks 36386 .. 36408
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1582 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1582" 385875968 16777216

end CS31aData.N13
