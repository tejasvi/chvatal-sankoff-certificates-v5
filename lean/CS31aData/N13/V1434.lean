import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1434 = cert_data/n13/h13c.vec.part1434, entries 138336534528 .. 138433003519, chunks 32982 .. 33004
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1434 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1434" 385875968 16777216

end CS31aData.N13
