import CS31aData.Elab

/-! h = 12 data: part 446 of h12_vdet_0.350500.bin (entries 22314122590 .. 22364154254). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v446 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part446" 400253320 33554432

end CS31aData.H12
