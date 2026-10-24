import CS31aData.Elab

/-! h = 12 data: part 2 of h12_keys.bin (entries 100063330 .. 150094994). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k2 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part002" 400253320 33554432

end CS31aData.H12
