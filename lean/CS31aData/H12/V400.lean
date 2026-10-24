import CS31aData.Elab

/-! h = 12 data: part 400 of h12_vdet_0.350500.bin (entries 20012666000 .. 20062697664). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v400 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part400" 400253320 33554432

end CS31aData.H12
