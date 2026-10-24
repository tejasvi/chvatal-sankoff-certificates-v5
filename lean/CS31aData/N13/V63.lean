import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 63 = cert_data/n13/h13c.vec.part0063, entries 6077546496 .. 6174015487, chunks 1449 .. 1471
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v63 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0063" 385875968 16777216

end CS31aData.N13
