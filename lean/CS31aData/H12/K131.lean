import CS31aData.Elab

/-! h = 12 data: part 131 of h12_keys.bin (entries 6554148115 .. 6604179779). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k131 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part131" 400253320 33554432

end CS31aData.H12
