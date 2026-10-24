import CS31aData.Elab

/-! h = 12 data: part 88 of h12_keys.bin (entries 4402786520 .. 4452818184). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k88 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part088" 400253320 33554432

end CS31aData.H12
