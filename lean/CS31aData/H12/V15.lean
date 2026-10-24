import CS31aData.Elab

/-! h = 12 data: part 15 of h12_vdet_0.350500.bin (entries 750474975 .. 800506639). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v15 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part015" 400253320 33554432

end CS31aData.H12
