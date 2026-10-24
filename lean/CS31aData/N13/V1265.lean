import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1265 = cert_data/n13/h13c.vec.part1265, entries 122033274880 .. 122129743871, chunks 29095 .. 29117
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1265 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1265" 385875968 16777216

end CS31aData.N13
