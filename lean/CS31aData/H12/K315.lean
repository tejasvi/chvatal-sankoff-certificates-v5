import CS31aData.Elab

/-! h = 12 data: part 315 of h12_keys.bin (entries 15759974475 .. 15810006139). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k315 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part315" 400253320 33554432

end CS31aData.H12
