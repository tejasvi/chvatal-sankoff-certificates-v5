import CS31aData.Elab

/-! h = 12 data: part 411 of h12_keys.bin (entries 20563014315 .. 20613045979). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k411 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part411" 400253320 33554432

end CS31aData.H12
