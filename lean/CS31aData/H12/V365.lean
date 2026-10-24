import CS31aData.Elab

/-! h = 12 data: part 365 of h12_vdet_0.350500.bin (entries 18261557725 .. 18311589389). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v365 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part365" 400253320 33554432

end CS31aData.H12
