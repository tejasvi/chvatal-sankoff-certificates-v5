import CS31aData.Elab

/-! h = 12 data: part 305 of h12_vdet_0.350500.bin (entries 15259657825 .. 15309689489). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v305 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part305" 400253320 33554432

end CS31aData.H12
