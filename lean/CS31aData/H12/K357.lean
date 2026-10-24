import CS31aData.Elab

/-! h = 12 data: part 357 of h12_keys.bin (entries 17861304405 .. 17911336069). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k357 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part357" 400253320 33554432

end CS31aData.H12
