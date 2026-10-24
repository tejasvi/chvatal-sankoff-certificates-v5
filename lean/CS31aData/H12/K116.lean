import CS31aData.Elab

/-! h = 12 data: part 116 of h12_keys.bin (entries 5803673140 .. 5853704804). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k116 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part116" 400253320 33554432

end CS31aData.H12
