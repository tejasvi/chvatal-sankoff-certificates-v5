import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1552 = cert_data/n13/h13c.vec.part1552, entries 149719875584 .. 149816344575, chunks 35696 .. 35718
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1552 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1552" 385875968 16777216

end CS31aData.N13
