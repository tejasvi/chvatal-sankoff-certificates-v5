import CS31aData.Elab

/-! h = 12 data: part 360 of h12_keys.bin (entries 18011399400 .. 18061431064). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k360 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part360" 400253320 33554432

end CS31aData.H12
