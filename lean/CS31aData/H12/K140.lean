import CS31aData.Elab

/-! h = 12 data: part 140 of h12_keys.bin (entries 7004433100 .. 7054464764). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k140 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part140" 400253320 33554432

end CS31aData.H12
