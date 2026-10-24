import CS31aData.Elab

/-! h = 12 data: part 93 of h12_vdet_0.350500.bin (entries 4652944845 .. 4702976509). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v93 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part093" 400253320 33554432

end CS31aData.H12
