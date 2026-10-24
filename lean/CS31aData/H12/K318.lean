import CS31aData.Elab

/-! h = 12 data: part 318 of h12_keys.bin (entries 15910069470 .. 15960101134). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k318 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part318" 400253320 33554432

end CS31aData.H12
