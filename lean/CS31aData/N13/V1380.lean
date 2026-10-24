import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1380 = cert_data/n13/h13c.vec.part1380, entries 133127208960 .. 133223677951, chunks 31740 .. 31762
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1380 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1380" 385875968 16777216

end CS31aData.N13
