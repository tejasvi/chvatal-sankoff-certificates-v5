import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 13 = cert_data/n13/h13c.vec.part0013, entries 1254096896 .. 1350565887, chunks 299 .. 321
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v13 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0013" 385875968 16777216

end CS31aData.N13
