import CS31aData.Elab

/-! h = 12 data: part 250 of h12_keys.bin (entries 12507916250 .. 12557947914). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k250 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part250" 400253320 33554432

end CS31aData.H12
