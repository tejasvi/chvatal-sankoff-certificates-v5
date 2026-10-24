import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1076 = cert_data/n13/h13c.vec.part1076, entries 103800635392 .. 103897104383, chunks 24748 .. 24770
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1076 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1076" 385875968 16777216

end CS31aData.N13
