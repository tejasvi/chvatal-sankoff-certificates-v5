import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1156 = cert_data/n13/h13c.vec.part1156, entries 111518154752 .. 111614623743, chunks 26588 .. 26610
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1156 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1156" 385875968 16777216

end CS31aData.N13
