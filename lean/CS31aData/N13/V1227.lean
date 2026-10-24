import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1227 = cert_data/n13/h13c.vec.part1227, entries 118367453184 .. 118463922175, chunks 28221 .. 28243
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1227 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1227" 385875968 16777216

end CS31aData.N13
