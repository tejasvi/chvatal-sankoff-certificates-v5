import CS31aData.Elab

/-! h = 12 data: part 153 of h12_vdet_0.350500.bin (entries 7654844745 .. 7704876409). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v153 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part153" 400253320 33554432

end CS31aData.H12
