import CS31aData.Elab

/-! h = 12 data: part 175 of h12_vdet_0.350500.bin (entries 8755541375 .. 8805573039). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v175 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part175" 400253320 33554432

end CS31aData.H12
