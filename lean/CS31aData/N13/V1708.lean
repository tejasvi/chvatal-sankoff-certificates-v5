import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1708 = cert_data/n13/h13c.vec.part1708, entries 164769038336 .. 164865507327, chunks 39284 .. 39306
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1708 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1708" 385875968 16777216

end CS31aData.N13
