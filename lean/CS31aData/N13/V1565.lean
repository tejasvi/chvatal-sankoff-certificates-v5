import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1565 = cert_data/n13/h13c.vec.part1565, entries 150973972480 .. 151070441471, chunks 35995 .. 36017
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1565 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1565" 385875968 16777216

end CS31aData.N13
