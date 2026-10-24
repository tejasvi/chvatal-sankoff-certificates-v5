import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1640 = cert_data/n13/h13c.vec.part1640, entries 158209146880 .. 158305615871, chunks 37720 .. 37742
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1640 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1640" 385875968 16777216

end CS31aData.N13
