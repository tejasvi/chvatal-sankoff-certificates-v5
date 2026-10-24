import CS31aData.Elab

/-! h = 12 data: part 89 of h12_keys.bin (entries 4452818185 .. 4502849849). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k89 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part089" 400253320 33554432

end CS31aData.H12
