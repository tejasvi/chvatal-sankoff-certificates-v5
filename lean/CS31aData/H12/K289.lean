import CS31aData.Elab

/-! h = 12 data: part 289 of h12_keys.bin (entries 14459151185 .. 14509182849). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k289 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part289" 400253320 33554432

end CS31aData.H12
