import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1127 = cert_data/n13/h13c.vec.part1127, entries 108720553984 .. 108817022975, chunks 25921 .. 25943
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1127 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1127" 385875968 16777216

end CS31aData.N13
