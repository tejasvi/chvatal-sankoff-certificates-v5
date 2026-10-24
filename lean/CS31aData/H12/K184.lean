import CS31aData.Elab

/-! h = 12 data: part 184 of h12_keys.bin (entries 9205826360 .. 9255858024). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k184 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part184" 400253320 33554432

end CS31aData.H12
