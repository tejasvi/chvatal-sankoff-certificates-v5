import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1544 = cert_data/n13/h13c.vec.part1544, entries 148948123648 .. 149044592639, chunks 35512 .. 35534
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1544 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1544" 385875968 16777216

end CS31aData.N13
