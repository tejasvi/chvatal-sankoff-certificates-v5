import CS31aData.Elab

/-! h = 12 data: part 253 of h12_keys.bin (entries 12658011245 .. 12708042909). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k253 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part253" 400253320 33554432

end CS31aData.H12
