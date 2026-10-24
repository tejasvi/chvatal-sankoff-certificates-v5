import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1657 = cert_data/n13/h13c.vec.part1657, entries 159849119744 .. 159945588735, chunks 38111 .. 38133
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1657 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1657" 385875968 16777216

end CS31aData.N13
