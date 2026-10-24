import CS31aData.Elab

/-! h = 12 data: part 356 of h12_keys.bin (entries 17811272740 .. 17861304404). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k356 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part356" 400253320 33554432

end CS31aData.H12
