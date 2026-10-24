import CS31aData.Elab

/-! h = 12 data: part 393 of h12_keys.bin (entries 19662444345 .. 19712476009). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k393 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part393" 400253320 33554432

end CS31aData.H12
