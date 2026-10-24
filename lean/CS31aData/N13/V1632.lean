import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1632 = cert_data/n13/h13c.vec.part1632, entries 157437394944 .. 157533863935, chunks 37536 .. 37558
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1632 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1632" 385875968 16777216

end CS31aData.N13
