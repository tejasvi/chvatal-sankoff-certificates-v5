import CS31aData.Elab

/-! h = 12 data: part 368 of h12_keys.bin (entries 18411652720 .. 18461684384). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k368 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part368" 400253320 33554432

end CS31aData.H12
