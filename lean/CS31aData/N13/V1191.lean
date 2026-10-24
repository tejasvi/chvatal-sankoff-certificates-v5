import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1191 = cert_data/n13/h13c.vec.part1191, entries 114894569472 .. 114991038463, chunks 27393 .. 27415
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1191 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1191" 385875968 16777216

end CS31aData.N13
