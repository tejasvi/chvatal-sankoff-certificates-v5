import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1139 = cert_data/n13/h13c.vec.part1139, entries 109878181888 .. 109974650879, chunks 26197 .. 26219
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1139 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1139" 385875968 16777216

end CS31aData.N13
