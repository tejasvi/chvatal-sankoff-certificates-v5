import CS31aData.Elab

/-! h = 12 data: part 94 of h12_keys.bin (entries 4702976510 .. 4753008174). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k94 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part094" 400253320 33554432

end CS31aData.H12
