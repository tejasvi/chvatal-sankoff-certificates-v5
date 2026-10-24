import CS31aData.Elab

/-! h = 12 data: part 419 of h12_keys.bin (entries 20963267635 .. 21013299299). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k419 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part419" 400253320 33554432

end CS31aData.H12
