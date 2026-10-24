import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 691 = cert_data/n13/h13c.vec.part0691, entries 66660073472 .. 66756542463, chunks 15893 .. 15915
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v691 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0691" 385875968 16777216

end CS31aData.N13
