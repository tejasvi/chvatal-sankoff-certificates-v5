import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 306 = cert_data/n13/h13c.vec.part0306, entries 29519511552 .. 29615980543, chunks 7038 .. 7060
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v306 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0306" 385875968 16777216

end CS31aData.N13
