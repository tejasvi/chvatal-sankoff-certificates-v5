import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1179 = cert_data/n13/h13c.vec.part1179, entries 113736941568 .. 113833410559, chunks 27117 .. 27139
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1179 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1179" 385875968 16777216

end CS31aData.N13
