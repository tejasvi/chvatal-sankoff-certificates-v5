import CS31aData.Elab

/-! h = 12 data: part 50 of h12_keys.bin (entries 2501583250 .. 2551614914). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k50 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part050" 400253320 33554432

end CS31aData.H12
