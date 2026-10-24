import CS31aData.Elab

/-! h = 12 data: part 125 of h12_vdet_0.350500.bin (entries 6253958125 .. 6303989789). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v125 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part125" 400253320 33554432

end CS31aData.H12
