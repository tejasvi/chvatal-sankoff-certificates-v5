import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 186 = cert_data/n13/h13c.vec.part0186, entries 17943232512 .. 18039701503, chunks 4278 .. 4300
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v186 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0186" 385875968 16777216

end CS31aData.N13
