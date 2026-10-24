import CS31aData.Elab

/-! h = 12 data: part 296 of h12_keys.bin (entries 14809372840 .. 14859404504). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k296 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part296" 400253320 33554432

end CS31aData.H12
