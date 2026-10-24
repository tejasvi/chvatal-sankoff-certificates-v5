import CS31aData.Elab

/-! h = 12 data: part 342 of h12_keys.bin (entries 17110829430 .. 17160861094). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k342 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part342" 400253320 33554432

end CS31aData.H12
