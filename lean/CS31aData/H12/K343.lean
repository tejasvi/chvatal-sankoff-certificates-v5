import CS31aData.Elab

/-! h = 12 data: part 343 of h12_keys.bin (entries 17160861095 .. 17210892759). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k343 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part343" 400253320 33554432

end CS31aData.H12
