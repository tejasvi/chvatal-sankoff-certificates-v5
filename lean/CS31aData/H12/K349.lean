import CS31aData.Elab

/-! h = 12 data: part 349 of h12_keys.bin (entries 17461051085 .. 17511082749). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k349 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part349" 400253320 33554432

end CS31aData.H12
