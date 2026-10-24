import CS31aData.Elab

/-! h = 12 data: part 364 of h12_keys.bin (entries 18211526060 .. 18261557724). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k364 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part364" 400253320 33554432

end CS31aData.H12
