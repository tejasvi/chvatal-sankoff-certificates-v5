import CS31aData.Elab

/-! h = 12 data: part 65 of h12_keys.bin (entries 3252058225 .. 3302089889). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k65 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part065" 400253320 33554432

end CS31aData.H12
