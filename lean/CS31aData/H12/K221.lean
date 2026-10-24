import CS31aData.Elab

/-! h = 12 data: part 221 of h12_keys.bin (entries 11056997965 .. 11107029629). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k221 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part221" 400253320 33554432

end CS31aData.H12
