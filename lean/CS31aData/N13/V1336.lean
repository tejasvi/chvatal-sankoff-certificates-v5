import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1336 = cert_data/n13/h13c.vec.part1336, entries 128882573312 .. 128979042303, chunks 30728 .. 30750
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1336 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1336" 385875968 16777216

end CS31aData.N13
