import CS31aData.Elab

/-! h = 12 data: part 285 of h12_keys.bin (entries 14259024525 .. 14309056189). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k285 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part285" 400253320 33554432

end CS31aData.H12
