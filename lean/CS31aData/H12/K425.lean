import CS31aData.Elab

/-! h = 12 data: part 425 of h12_keys.bin (entries 21263457625 .. 21313489289). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k425 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part425" 400253320 33554432

end CS31aData.H12
