import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1682 = cert_data/n13/h13c.vec.part1682, entries 162260844544 .. 162357313535, chunks 38686 .. 38708
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1682 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1682" 385875968 16777216

end CS31aData.N13
