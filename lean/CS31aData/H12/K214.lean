import CS31aData.Elab

/-! h = 12 data: part 214 of h12_keys.bin (entries 10706776310 .. 10756807974). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k214 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part214" 400253320 33554432

end CS31aData.H12
