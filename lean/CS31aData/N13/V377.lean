import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 377 = cert_data/n13/h13c.vec.part0377, entries 36368809984 .. 36465278975, chunks 8671 .. 8693
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v377 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0377" 385875968 16777216

end CS31aData.N13
