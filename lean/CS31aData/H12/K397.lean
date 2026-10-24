import CS31aData.Elab

/-! h = 12 data: part 397 of h12_keys.bin (entries 19862571005 .. 19912602669). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k397 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part397" 400253320 33554432

end CS31aData.H12
