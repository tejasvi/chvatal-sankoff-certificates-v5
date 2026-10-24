import CS31aData.Elab

/-! h = 12 data: part 139 of h12_keys.bin (entries 6954401435 .. 7004433099). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k139 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part139" 400253320 33554432

end CS31aData.H12
