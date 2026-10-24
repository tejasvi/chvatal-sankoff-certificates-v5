import CS31aData.Elab

/-! h = 12 data: part 441 of h12_keys.bin (entries 22063964265 .. 22113995929). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k441 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part441" 400253320 33554432

end CS31aData.H12
