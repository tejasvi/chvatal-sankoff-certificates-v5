import CS31aData.Elab

/-! h = 12 data: part 121 of h12_keys.bin (entries 6053831465 .. 6103863129). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k121 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part121" 400253320 33554432

end CS31aData.H12
