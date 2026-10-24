import CS31aData.Elab

/-! h = 12 data: part 323 of h12_keys.bin (entries 16160227795 .. 16210259459). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k323 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part323" 400253320 33554432

end CS31aData.H12
