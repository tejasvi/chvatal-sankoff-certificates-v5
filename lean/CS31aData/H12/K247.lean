import CS31aData.Elab

/-! h = 12 data: part 247 of h12_keys.bin (entries 12357821255 .. 12407852919). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k247 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part247" 400253320 33554432

end CS31aData.H12
