import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1128 = cert_data/n13/h13c.vec.part1128, entries 108817022976 .. 108913491967, chunks 25944 .. 25966
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1128 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1128" 385875968 16777216

end CS31aData.N13
