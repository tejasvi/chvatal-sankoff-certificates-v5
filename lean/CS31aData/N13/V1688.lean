import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1688 = cert_data/n13/h13c.vec.part1688, entries 162839658496 .. 162936127487, chunks 38824 .. 38846
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1688 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1688" 385875968 16777216

end CS31aData.N13
