import CS31aData.Elab

/-! h = 12 data: part 16 of h12_vdet_0.350500.bin (entries 800506640 .. 850538304). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v16 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part016" 400253320 33554432

end CS31aData.H12
