import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1563 = cert_data/n13/h13c.vec.part1563, entries 150781034496 .. 150877503487, chunks 35949 .. 35971
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1563 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1563" 385875968 16777216

end CS31aData.N13
