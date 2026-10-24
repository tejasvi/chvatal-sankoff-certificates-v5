import CS31aData.Elab

/-! h = 12 data: part 103 of h12_keys.bin (entries 5153261495 .. 5203293159). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k103 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part103" 400253320 33554432

end CS31aData.H12
