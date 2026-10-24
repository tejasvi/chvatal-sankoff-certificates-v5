import CS31aData.Elab

/-! h = 12 data: part 11 of h12_keys.bin (entries 550348315 .. 600379979). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k11 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part011" 400253320 33554432

end CS31aData.H12
