import CS31aData.Elab

/-! h = 12 data: part 168 of h12_keys.bin (entries 8405319720 .. 8455351384). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k168 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part168" 400253320 33554432

end CS31aData.H12
