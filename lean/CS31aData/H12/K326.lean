import CS31aData.Elab

/-! h = 12 data: part 326 of h12_keys.bin (entries 16310322790 .. 16360354454). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k326 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part326" 400253320 33554432

end CS31aData.H12
