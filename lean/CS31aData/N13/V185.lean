import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 185 = cert_data/n13/h13c.vec.part0185, entries 17846763520 .. 17943232511, chunks 4255 .. 4277
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v185 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0185" 385875968 16777216

end CS31aData.N13
