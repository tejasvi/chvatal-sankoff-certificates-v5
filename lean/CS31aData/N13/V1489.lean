import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1489 = cert_data/n13/h13c.vec.part1489, entries 143642329088 .. 143738798079, chunks 34247 .. 34269
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1489 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1489" 385875968 16777216

end CS31aData.N13
