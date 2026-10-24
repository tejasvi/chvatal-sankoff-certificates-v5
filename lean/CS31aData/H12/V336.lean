import CS31aData.Elab

/-! h = 12 data: part 336 of h12_vdet_0.350500.bin (entries 16810639440 .. 16860671104). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v336 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part336" 400253320 33554432

end CS31aData.H12
