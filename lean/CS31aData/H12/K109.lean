import CS31aData.Elab

/-! h = 12 data: part 109 of h12_keys.bin (entries 5453451485 .. 5503483149). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k109 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part109" 400253320 33554432

end CS31aData.H12
