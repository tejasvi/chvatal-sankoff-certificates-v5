import CS31aData.Elab

/-! h = 12 data: part 21 of h12_keys.bin (entries 1050664965 .. 1100696629). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k21 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part021" 400253320 33554432

end CS31aData.H12
