import CS31aData.Elab

/-! h = 12 data: part 115 of h12_keys.bin (entries 5753641475 .. 5803673139). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k115 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part115" 400253320 33554432

end CS31aData.H12
