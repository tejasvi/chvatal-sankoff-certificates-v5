import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1075 = cert_data/n13/h13c.vec.part1075, entries 103704166400 .. 103800635391, chunks 24725 .. 24747
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1075 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1075" 385875968 16777216

end CS31aData.N13
