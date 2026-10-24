import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1540 = cert_data/n13/h13c.vec.part1540, entries 148562247680 .. 148658716671, chunks 35420 .. 35442
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1540 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1540" 385875968 16777216

end CS31aData.N13
