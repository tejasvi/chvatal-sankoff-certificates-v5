import CS31aData.Elab

/-! h = 12 data: part 252 of h12_vdet_0.350500.bin (entries 12607979580 .. 12658011244). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v252 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part252" 400253320 33554432

end CS31aData.H12
