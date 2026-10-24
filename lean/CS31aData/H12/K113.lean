import CS31aData.Elab

/-! h = 12 data: part 113 of h12_keys.bin (entries 5653578145 .. 5703609809). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k113 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part113" 400253320 33554432

end CS31aData.H12
