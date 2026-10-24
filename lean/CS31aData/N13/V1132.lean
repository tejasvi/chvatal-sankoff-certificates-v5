import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1132 = cert_data/n13/h13c.vec.part1132, entries 109202898944 .. 109299367935, chunks 26036 .. 26058
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1132 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1132" 385875968 16777216

end CS31aData.N13
