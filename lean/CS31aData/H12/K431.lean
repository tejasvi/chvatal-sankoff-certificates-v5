import CS31aData.Elab

/-! h = 12 data: part 431 of h12_keys.bin (entries 21563647615 .. 21613679279). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k431 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part431" 400253320 33554432

end CS31aData.H12
