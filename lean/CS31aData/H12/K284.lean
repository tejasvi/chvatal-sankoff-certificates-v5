import CS31aData.Elab

/-! h = 12 data: part 284 of h12_keys.bin (entries 14208992860 .. 14259024524). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k284 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part284" 400253320 33554432

end CS31aData.H12
