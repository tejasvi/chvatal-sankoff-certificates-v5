import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1121 = cert_data/n13/h13c.vec.part1121, entries 108141740032 .. 108238209023, chunks 25783 .. 25805
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1121 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1121" 385875968 16777216

end CS31aData.N13
