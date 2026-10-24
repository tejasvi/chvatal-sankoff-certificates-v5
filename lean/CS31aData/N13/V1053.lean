import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1053 = cert_data/n13/h13c.vec.part1053, entries 101581848576 .. 101678317567, chunks 24219 .. 24241
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1053 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1053" 385875968 16777216

end CS31aData.N13
