import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 347 = cert_data/n13/h13c.vec.part0347, entries 33474740224 .. 33571209215, chunks 7981 .. 8003
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v347 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0347" 385875968 16777216

end CS31aData.N13
