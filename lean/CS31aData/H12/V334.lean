import CS31aData.Elab

/-! h = 12 data: part 334 of h12_vdet_0.350500.bin (entries 16710576110 .. 16760607774). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v334 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part334" 400253320 33554432

end CS31aData.H12
