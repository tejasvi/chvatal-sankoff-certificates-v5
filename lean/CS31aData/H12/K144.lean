import CS31aData.Elab

/-! h = 12 data: part 144 of h12_keys.bin (entries 7204559760 .. 7254591424). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k144 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part144" 400253320 33554432

end CS31aData.H12
