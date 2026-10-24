import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1411 = cert_data/n13/h13c.vec.part1411, entries 136117747712 .. 136214216703, chunks 32453 .. 32475
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1411 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1411" 385875968 16777216

end CS31aData.N13
