import CS31aData.Elab

/-! h = 12 data: part 369 of h12_vdet_0.350500.bin (entries 18461684385 .. 18511716049). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v369 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part369" 400253320 33554432

end CS31aData.H12
