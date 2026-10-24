import CS31aData.Elab

/-! h = 12 data: part 278 of h12_keys.bin (entries 13908802870 .. 13958834534). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k278 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part278" 400253320 33554432

end CS31aData.H12
