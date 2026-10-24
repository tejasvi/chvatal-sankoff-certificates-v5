import CS31aData.Elab

/-! h = 12 data: part 370 of h12_vdet_0.350500.bin (entries 18511716050 .. 18561747714). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v370 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part370" 400253320 33554432

end CS31aData.H12
