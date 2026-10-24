import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 225 = cert_data/n13/h13c.vec.part0225, entries 21705523200 .. 21801992191, chunks 5175 .. 5197
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v225 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0225" 385875968 16777216

end CS31aData.N13
