import CS31aData.Elab

/-! h = 12 data: part 127 of h12_vdet_0.350500.bin (entries 6354021455 .. 6404053119). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v127 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part127" 400253320 33554432

end CS31aData.H12
