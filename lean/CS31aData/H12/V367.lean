import CS31aData.Elab

/-! h = 12 data: part 367 of h12_vdet_0.350500.bin (entries 18361621055 .. 18411652719). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v367 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part367" 400253320 33554432

end CS31aData.H12
