import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1264 = cert_data/n13/h13c.vec.part1264, entries 121936805888 .. 122033274879, chunks 29072 .. 29094
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1264 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1264" 385875968 16777216

end CS31aData.N13
