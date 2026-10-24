import CS31aData.Elab

/-! h = 12 data: part 22 of h12_keys.bin (entries 1100696630 .. 1150728294). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k22 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part022" 400253320 33554432

end CS31aData.H12
