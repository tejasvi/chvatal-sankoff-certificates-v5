import CS31aData.Elab

/-! h = 12 data: part 452 of h12_keys.bin (entries 22614312580 .. 22664344244). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k452 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part452" 400253320 33554432

end CS31aData.H12
