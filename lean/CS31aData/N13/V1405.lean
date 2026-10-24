import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1405 = cert_data/n13/h13c.vec.part1405, entries 135538933760 .. 135635402751, chunks 32315 .. 32337
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1405 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1405" 385875968 16777216

end CS31aData.N13
