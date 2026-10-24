import CS31aData.Elab

/-! h = 12 data: part 225 of h12_keys.bin (entries 11257124625 .. 11307156289). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k225 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part225" 400253320 33554432

end CS31aData.H12
