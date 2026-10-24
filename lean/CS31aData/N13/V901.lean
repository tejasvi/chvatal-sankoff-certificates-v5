import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 901 = cert_data/n13/h13c.vec.part0901, entries 86918561792 .. 87015030783, chunks 20723 .. 20745
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v901 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0901" 385875968 16777216

end CS31aData.N13
