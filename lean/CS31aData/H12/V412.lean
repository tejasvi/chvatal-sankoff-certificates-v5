import CS31aData.Elab

/-! h = 12 data: part 412 of h12_vdet_0.350500.bin (entries 20613045980 .. 20663077644). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v412 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part412" 400253320 33554432

end CS31aData.H12
