import CS31aData.Elab

/-! h = 12 data: part 186 of h12_keys.bin (entries 9305889690 .. 9355921354). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k186 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part186" 400253320 33554432

end CS31aData.H12
