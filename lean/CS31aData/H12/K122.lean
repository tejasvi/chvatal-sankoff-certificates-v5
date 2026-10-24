import CS31aData.Elab

/-! h = 12 data: part 122 of h12_keys.bin (entries 6103863130 .. 6153894794). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k122 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part122" 400253320 33554432

end CS31aData.H12
