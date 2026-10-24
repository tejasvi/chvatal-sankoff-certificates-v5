import CS31aData.Elab

/-! h = 12 data: part 220 of h12_vdet_0.350500.bin (entries 11006966300 .. 11056997964). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v220 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part220" 400253320 33554432

end CS31aData.H12
