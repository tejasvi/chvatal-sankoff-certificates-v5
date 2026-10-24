import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1702 = cert_data/n13/h13c.vec.part1702, entries 164190224384 .. 164286693375, chunks 39146 .. 39168
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1702 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1702" 385875968 16777216

end CS31aData.N13
