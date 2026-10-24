import CS31aData.Elab

/-! h = 12 data: part 358 of h12_keys.bin (entries 17911336070 .. 17961367734). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k358 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part358" 400253320 33554432

end CS31aData.H12
