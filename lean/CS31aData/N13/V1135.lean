import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1135 = cert_data/n13/h13c.vec.part1135, entries 109492305920 .. 109588774911, chunks 26105 .. 26127
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1135 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1135" 385875968 16777216

end CS31aData.N13
