import CS31aData.Elab

/-! h = 12 data: part 100 of h12_vdet_0.350500.bin (entries 5003166500 .. 5053198164). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v100 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part100" 400253320 33554432

end CS31aData.H12
