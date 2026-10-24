import CS31aData.Elab

/-! h = 12 data: part 54 of h12_keys.bin (entries 2701709910 .. 2751741574). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k54 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part054" 400253320 33554432

end CS31aData.H12
