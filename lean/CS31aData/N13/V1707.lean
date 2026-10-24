import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1707 = cert_data/n13/h13c.vec.part1707, entries 164672569344 .. 164769038335, chunks 39261 .. 39283
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1707 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1707" 385875968 16777216

end CS31aData.N13
