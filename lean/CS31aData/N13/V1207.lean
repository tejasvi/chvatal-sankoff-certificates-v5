import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1207 = cert_data/n13/h13c.vec.part1207, entries 116438073344 .. 116534542335, chunks 27761 .. 27783
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1207 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1207" 385875968 16777216

end CS31aData.N13
