import CS31aData.Elab

/-! h = 12 data: part 32 of h12_vdet_0.350500.bin (entries 1601013280 .. 1651044944). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v32 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part032" 400253320 33554432

end CS31aData.H12
