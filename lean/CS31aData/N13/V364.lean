import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 364 = cert_data/n13/h13c.vec.part0364, entries 35114713088 .. 35211182079, chunks 8372 .. 8394
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v364 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0364" 385875968 16777216

end CS31aData.N13
