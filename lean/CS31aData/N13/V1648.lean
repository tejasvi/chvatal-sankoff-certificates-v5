import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1648 = cert_data/n13/h13c.vec.part1648, entries 158980898816 .. 159077367807, chunks 37904 .. 37926
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1648 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1648" 385875968 16777216

end CS31aData.N13
