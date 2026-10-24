import CS31aData.Elab

/-! h = 12 data: part 176 of h12_vdet_0.350500.bin (entries 8805573040 .. 8855604704). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v176 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part176" 400253320 33554432

end CS31aData.H12
