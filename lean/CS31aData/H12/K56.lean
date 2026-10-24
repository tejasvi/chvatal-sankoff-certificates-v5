import CS31aData.Elab

/-! h = 12 data: part 56 of h12_keys.bin (entries 2801773240 .. 2851804904). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k56 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part056" 400253320 33554432

end CS31aData.H12
