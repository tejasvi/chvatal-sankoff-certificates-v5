import CS31aData.Elab

/-! h = 12 data: part 141 of h12_keys.bin (entries 7054464765 .. 7104496429). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k141 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part141" 400253320 33554432

end CS31aData.H12
