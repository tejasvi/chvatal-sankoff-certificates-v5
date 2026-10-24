import CS31aData.Elab

/-! h = 12 data: part 323 of h12_vdet_0.350500.bin (entries 16160227795 .. 16210259459). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v323 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part323" 400253320 33554432

end CS31aData.H12
