import CS31aData.Elab

/-! h = 12 data: part 134 of h12_keys.bin (entries 6704243110 .. 6754274774). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k134 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part134" 400253320 33554432

end CS31aData.H12
