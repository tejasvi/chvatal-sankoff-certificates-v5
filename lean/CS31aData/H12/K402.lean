import CS31aData.Elab

/-! h = 12 data: part 402 of h12_keys.bin (entries 20112729330 .. 20162760994). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k402 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part402" 400253320 33554432

end CS31aData.H12
