import CS31aData.Elab

/-! h = 12 data: part 5 of h12_keys.bin (entries 250158325 .. 300189989). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k5 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part005" 400253320 33554432

end CS31aData.H12
