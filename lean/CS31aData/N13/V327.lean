import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 327 = cert_data/n13/h13c.vec.part0327, entries 31545360384 .. 31641829375, chunks 7521 .. 7543
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v327 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0327" 385875968 16777216

end CS31aData.N13
