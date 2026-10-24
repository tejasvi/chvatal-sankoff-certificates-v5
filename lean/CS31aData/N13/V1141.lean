import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1141 = cert_data/n13/h13c.vec.part1141, entries 110071119872 .. 110167588863, chunks 26243 .. 26265
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1141 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1141" 385875968 16777216

end CS31aData.N13
