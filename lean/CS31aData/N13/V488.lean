import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 488 = cert_data/n13/h13c.vec.part0488, entries 47076868096 .. 47173337087, chunks 11224 .. 11246
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v488 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0488" 385875968 16777216

end CS31aData.N13
