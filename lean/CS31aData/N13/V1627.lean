import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1627 = cert_data/n13/h13c.vec.part1627, entries 156955049984 .. 157051518975, chunks 37421 .. 37443
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1627 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1627" 385875968 16777216

end CS31aData.N13
