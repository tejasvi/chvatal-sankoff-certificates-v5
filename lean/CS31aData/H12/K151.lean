import CS31aData.Elab

/-! h = 12 data: part 151 of h12_keys.bin (entries 7554781415 .. 7604813079). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k151 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part151" 400253320 33554432

end CS31aData.H12
