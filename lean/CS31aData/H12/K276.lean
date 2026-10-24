import CS31aData.Elab

/-! h = 12 data: part 276 of h12_keys.bin (entries 13808739540 .. 13858771204). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k276 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part276" 400253320 33554432

end CS31aData.H12
