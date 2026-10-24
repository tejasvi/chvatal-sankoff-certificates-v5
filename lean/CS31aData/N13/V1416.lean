import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1416 = cert_data/n13/h13c.vec.part1416, entries 136600092672 .. 136696561663, chunks 32568 .. 32590
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1416 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1416" 385875968 16777216

end CS31aData.N13
