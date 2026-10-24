import CS31aData.Elab

/-! h = 12 data: part 339 of h12_keys.bin (entries 16960734435 .. 17010766099). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k339 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part339" 400253320 33554432

end CS31aData.H12
