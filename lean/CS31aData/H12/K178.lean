import CS31aData.Elab

/-! h = 12 data: part 178 of h12_keys.bin (entries 8905636370 .. 8955668034). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k178 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part178" 400253320 33554432

end CS31aData.H12
