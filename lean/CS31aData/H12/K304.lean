import CS31aData.Elab

/-! h = 12 data: part 304 of h12_keys.bin (entries 15209626160 .. 15259657824). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k304 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part304" 400253320 33554432

end CS31aData.H12
