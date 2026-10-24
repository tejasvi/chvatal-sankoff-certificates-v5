import CS31aData.Elab

/-! h = 12 data: part 453 of h12_keys.bin (entries 22664344245 .. 22670087100). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k453 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part453" 45942848 33554432

end CS31aData.H12
