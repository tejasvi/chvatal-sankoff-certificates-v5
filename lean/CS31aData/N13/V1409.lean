import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1409 = cert_data/n13/h13c.vec.part1409, entries 135924809728 .. 136021278719, chunks 32407 .. 32429
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1409 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1409" 385875968 16777216

end CS31aData.N13
