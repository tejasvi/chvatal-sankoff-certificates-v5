import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1271 = cert_data/n13/h13c.vec.part1271, entries 122612088832 .. 122708557823, chunks 29233 .. 29255
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1271 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1271" 385875968 16777216

end CS31aData.N13
