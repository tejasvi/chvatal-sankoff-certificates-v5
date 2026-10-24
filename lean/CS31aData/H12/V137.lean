import CS31aData.Elab

/-! h = 12 data: part 137 of h12_vdet_0.350500.bin (entries 6854338105 .. 6904369769). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v137 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part137" 400253320 33554432

end CS31aData.H12
