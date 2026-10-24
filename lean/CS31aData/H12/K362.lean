import CS31aData.Elab

/-! h = 12 data: part 362 of h12_keys.bin (entries 18111462730 .. 18161494394). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k362 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part362" 400253320 33554432

end CS31aData.H12
