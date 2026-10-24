import CS31aData.Elab

/-! h = 12 data: part 157 of h12_keys.bin (entries 7854971405 .. 7905003069). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k157 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part157" 400253320 33554432

end CS31aData.H12
