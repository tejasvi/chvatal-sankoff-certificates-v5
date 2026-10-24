import CS31aData.Elab

/-! h = 12 data: part 322 of h12_keys.bin (entries 16110196130 .. 16160227794). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k322 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part322" 400253320 33554432

end CS31aData.H12
