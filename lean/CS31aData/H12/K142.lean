import CS31aData.Elab

/-! h = 12 data: part 142 of h12_keys.bin (entries 7104496430 .. 7154528094). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k142 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part142" 400253320 33554432

end CS31aData.H12
