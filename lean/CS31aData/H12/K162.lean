import CS31aData.Elab

/-! h = 12 data: part 162 of h12_keys.bin (entries 8105129730 .. 8155161394). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k162 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part162" 400253320 33554432

end CS31aData.H12
