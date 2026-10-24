import CS31aData.Elab

/-! h = 12 data: part 76 of h12_keys.bin (entries 3802406540 .. 3852438204). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k76 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part076" 400253320 33554432

end CS31aData.H12
