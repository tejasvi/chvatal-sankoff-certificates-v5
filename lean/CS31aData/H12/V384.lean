import CS31aData.Elab

/-! h = 12 data: part 384 of h12_vdet_0.350500.bin (entries 19212159360 .. 19262191024). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v384 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part384" 400253320 33554432

end CS31aData.H12
