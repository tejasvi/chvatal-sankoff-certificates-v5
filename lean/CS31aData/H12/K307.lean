import CS31aData.Elab

/-! h = 12 data: part 307 of h12_keys.bin (entries 15359721155 .. 15409752819). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k307 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part307" 400253320 33554432

end CS31aData.H12
