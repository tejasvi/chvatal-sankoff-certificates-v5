import CS31aData.Elab

/-! h = 12 data: part 283 of h12_vdet_0.350500.bin (entries 14158961195 .. 14208992859). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v283 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part283" 400253320 33554432

end CS31aData.H12
