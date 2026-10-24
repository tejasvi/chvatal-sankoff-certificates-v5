import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1580 = cert_data/n13/h13c.vec.part1580, entries 152421007360 .. 152517476351, chunks 36340 .. 36362
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1580 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1580" 385875968 16777216

end CS31aData.N13
