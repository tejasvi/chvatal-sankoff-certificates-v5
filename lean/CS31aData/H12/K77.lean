import CS31aData.Elab

/-! h = 12 data: part 77 of h12_keys.bin (entries 3852438205 .. 3902469869). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k77 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part077" 400253320 33554432

end CS31aData.H12
