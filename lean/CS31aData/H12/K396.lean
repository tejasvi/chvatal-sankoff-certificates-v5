import CS31aData.Elab

/-! h = 12 data: part 396 of h12_keys.bin (entries 19812539340 .. 19862571004). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k396 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part396" 400253320 33554432

end CS31aData.H12
