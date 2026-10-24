import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1706 = cert_data/n13/h13c.vec.part1706, entries 164576100352 .. 164672569343, chunks 39238 .. 39260
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1706 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1706" 385875968 16777216

end CS31aData.N13
