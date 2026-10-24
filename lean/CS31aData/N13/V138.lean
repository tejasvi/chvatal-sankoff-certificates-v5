import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 138 = cert_data/n13/h13c.vec.part0138, entries 13312720896 .. 13409189887, chunks 3174 .. 3196
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v138 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0138" 385875968 16777216

end CS31aData.N13
