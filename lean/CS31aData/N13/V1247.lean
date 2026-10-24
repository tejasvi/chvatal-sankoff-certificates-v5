import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1247 = cert_data/n13/h13c.vec.part1247, entries 120296833024 .. 120393302015, chunks 28681 .. 28703
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1247 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1247" 385875968 16777216

end CS31aData.N13
