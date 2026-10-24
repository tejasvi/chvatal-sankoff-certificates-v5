import CS31aData.Elab

/-! h = 12 data: part 215 of h12_keys.bin (entries 10756807975 .. 10806839639). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k215 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part215" 400253320 33554432

end CS31aData.H12
