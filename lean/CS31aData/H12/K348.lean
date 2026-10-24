import CS31aData.Elab

/-! h = 12 data: part 348 of h12_keys.bin (entries 17411019420 .. 17461051084). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k348 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part348" 400253320 33554432

end CS31aData.H12
