import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1200 = cert_data/n13/h13c.vec.part1200, entries 115762790400 .. 115859259391, chunks 27600 .. 27622
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1200 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1200" 385875968 16777216

end CS31aData.N13
