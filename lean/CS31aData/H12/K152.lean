import CS31aData.Elab

/-! h = 12 data: part 152 of h12_keys.bin (entries 7604813080 .. 7654844744). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k152 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part152" 400253320 33554432

end CS31aData.H12
