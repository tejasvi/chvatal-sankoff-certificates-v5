import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1043 = cert_data/n13/h13c.vec.part1043, entries 100617158656 .. 100713627647, chunks 23989 .. 24011
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1043 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1043" 385875968 16777216

end CS31aData.N13
