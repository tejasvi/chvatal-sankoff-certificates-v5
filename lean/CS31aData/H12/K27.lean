import CS31aData.Elab

/-! h = 12 data: part 27 of h12_keys.bin (entries 1350854955 .. 1400886619). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k27 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part027" 400253320 33554432

end CS31aData.H12
