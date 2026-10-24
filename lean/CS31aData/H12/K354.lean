import CS31aData.Elab

/-! h = 12 data: part 354 of h12_keys.bin (entries 17711209410 .. 17761241074). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k354 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part354" 400253320 33554432

end CS31aData.H12
