import CS31aData.Elab

/-! h = 12 data: part 240 of h12_vdet_0.350500.bin (entries 12007599600 .. 12057631264). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v240 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part240" 400253320 33554432

end CS31aData.H12
