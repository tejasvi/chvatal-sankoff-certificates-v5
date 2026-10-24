import CS31aData.Elab

/-! h = 12 data: part 440 of h12_keys.bin (entries 22013932600 .. 22063964264). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k440 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part440" 400253320 33554432

end CS31aData.H12
