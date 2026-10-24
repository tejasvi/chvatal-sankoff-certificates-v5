import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1136 = cert_data/n13/h13c.vec.part1136, entries 109588774912 .. 109685243903, chunks 26128 .. 26150
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1136 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1136" 385875968 16777216

end CS31aData.N13
