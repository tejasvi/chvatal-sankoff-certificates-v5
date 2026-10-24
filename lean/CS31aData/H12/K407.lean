import CS31aData.Elab

/-! h = 12 data: part 407 of h12_keys.bin (entries 20362887655 .. 20412919319). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k407 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part407" 400253320 33554432

end CS31aData.H12
