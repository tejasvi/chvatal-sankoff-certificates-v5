import CS31aData.Elab

/-! h = 12 data: part 398 of h12_keys.bin (entries 19912602670 .. 19962634334). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k398 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part398" 400253320 33554432

end CS31aData.H12
