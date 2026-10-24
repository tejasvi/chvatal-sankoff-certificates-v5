import CS31aData.Elab

/-! h = 12 data: part 4 of h12_keys.bin (entries 200126660 .. 250158324). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k4 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part004" 400253320 33554432

end CS31aData.H12
