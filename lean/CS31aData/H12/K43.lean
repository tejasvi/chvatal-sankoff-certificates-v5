import CS31aData.Elab

/-! h = 12 data: part 43 of h12_keys.bin (entries 2151361595 .. 2201393259). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k43 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part043" 400253320 33554432

end CS31aData.H12
