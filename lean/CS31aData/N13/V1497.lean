import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1497 = cert_data/n13/h13c.vec.part1497, entries 144414081024 .. 144510550015, chunks 34431 .. 34453
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1497 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1497" 385875968 16777216

end CS31aData.N13
