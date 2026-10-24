import CS31aData.Elab

/-! h = 12 data: part 277 of h12_vdet_0.350500.bin (entries 13858771205 .. 13908802869). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v277 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part277" 400253320 33554432

end CS31aData.H12
