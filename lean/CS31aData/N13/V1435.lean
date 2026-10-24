import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1435 = cert_data/n13/h13c.vec.part1435, entries 138433003520 .. 138529472511, chunks 33005 .. 33027
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1435 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1435" 385875968 16777216

end CS31aData.N13
