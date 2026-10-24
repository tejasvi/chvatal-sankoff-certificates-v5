import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 414 = cert_data/n13/h13c.vec.part0414, entries 39938162688 .. 40034631679, chunks 9522 .. 9544
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v414 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0414" 385875968 16777216

end CS31aData.N13
