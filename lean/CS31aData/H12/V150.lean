import CS31aData.Elab

/-! h = 12 data: part 150 of h12_vdet_0.350500.bin (entries 7504749750 .. 7554781414). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v150 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part150" 400253320 33554432

end CS31aData.H12
