import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 503 = cert_data/n13/h13c.vec.part0503, entries 48523902976 .. 48620371967, chunks 11569 .. 11591
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v503 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0503" 385875968 16777216

end CS31aData.N13
