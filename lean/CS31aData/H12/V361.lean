import CS31aData.Elab

/-! h = 12 data: part 361 of h12_vdet_0.350500.bin (entries 18061431065 .. 18111462729). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v361 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part361" 400253320 33554432

end CS31aData.H12
