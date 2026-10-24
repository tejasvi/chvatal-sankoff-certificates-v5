import CS31aData.Elab

/-! h = 12 data: part 410 of h12_keys.bin (entries 20512982650 .. 20563014314). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k410 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part410" 400253320 33554432

end CS31aData.H12
