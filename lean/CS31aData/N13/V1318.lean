import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1318 = cert_data/n13/h13c.vec.part1318, entries 127146131456 .. 127242600447, chunks 30314 .. 30336
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1318 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1318" 385875968 16777216

end CS31aData.N13
