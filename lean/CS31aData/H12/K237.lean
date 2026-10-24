import CS31aData.Elab

/-! h = 12 data: part 237 of h12_keys.bin (entries 11857504605 .. 11907536269). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k237 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part237" 400253320 33554432

end CS31aData.H12
