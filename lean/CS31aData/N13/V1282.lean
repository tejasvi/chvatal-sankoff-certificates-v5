import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1282 = cert_data/n13/h13c.vec.part1282, entries 123673247744 .. 123769716735, chunks 29486 .. 29508
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1282 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1282" 385875968 16777216

end CS31aData.N13
