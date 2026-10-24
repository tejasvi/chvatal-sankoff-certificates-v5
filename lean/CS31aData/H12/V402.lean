import CS31aData.Elab

/-! h = 12 data: part 402 of h12_vdet_0.350500.bin (entries 20112729330 .. 20162760994). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v402 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part402" 400253320 33554432

end CS31aData.H12
