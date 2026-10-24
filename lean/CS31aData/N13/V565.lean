import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 565 = cert_data/n13/h13c.vec.part0565, entries 54504980480 .. 54601449471, chunks 12995 .. 13017
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v565 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0565" 385875968 16777216

end CS31aData.N13
