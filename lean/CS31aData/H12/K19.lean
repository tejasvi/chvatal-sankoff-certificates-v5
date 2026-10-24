import CS31aData.Elab

/-! h = 12 data: part 19 of h12_keys.bin (entries 950601635 .. 1000633299). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k19 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part019" 400253320 33554432

end CS31aData.H12
