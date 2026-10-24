import CS31aData.Elab

/-! h = 12 data: part 324 of h12_keys.bin (entries 16210259460 .. 16260291124). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k324 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part324" 400253320 33554432

end CS31aData.H12
