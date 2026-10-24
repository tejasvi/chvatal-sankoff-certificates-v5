import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1065 = cert_data/n13/h13c.vec.part1065, entries 102739476480 .. 102835945471, chunks 24495 .. 24517
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1065 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1065" 385875968 16777216

end CS31aData.N13
