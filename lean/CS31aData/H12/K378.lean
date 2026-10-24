import CS31aData.Elab

/-! h = 12 data: part 378 of h12_keys.bin (entries 18911969370 .. 18962001034). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k378 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part378" 400253320 33554432

end CS31aData.H12
