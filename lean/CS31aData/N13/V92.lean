import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 92 = cert_data/n13/h13c.vec.part0092, entries 8875147264 .. 8971616255, chunks 2116 .. 2138
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v92 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0092" 385875968 16777216

end CS31aData.N13
