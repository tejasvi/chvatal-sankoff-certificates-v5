import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 408 = cert_data/n13/h13c.vec.part0408, entries 39359348736 .. 39455817727, chunks 9384 .. 9406
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v408 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0408" 385875968 16777216

end CS31aData.N13
