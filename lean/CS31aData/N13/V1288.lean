import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1288 = cert_data/n13/h13c.vec.part1288, entries 124252061696 .. 124348530687, chunks 29624 .. 29646
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1288 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1288" 385875968 16777216

end CS31aData.N13
