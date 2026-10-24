import CS31aData.Elab

/-! h = 12 data: part 112 of h12_vdet_0.350500.bin (entries 5603546480 .. 5653578144). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v112 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part112" 400253320 33554432

end CS31aData.H12
