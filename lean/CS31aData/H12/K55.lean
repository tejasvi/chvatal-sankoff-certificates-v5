import CS31aData.Elab

/-! h = 12 data: part 55 of h12_keys.bin (entries 2751741575 .. 2801773239). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k55 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part055" 400253320 33554432

end CS31aData.H12
