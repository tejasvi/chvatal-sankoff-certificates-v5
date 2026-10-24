import CS31aData.Elab

/-! h = 12 data: part 198 of h12_keys.bin (entries 9906269670 .. 9956301334). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k198 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part198" 400253320 33554432

end CS31aData.H12
