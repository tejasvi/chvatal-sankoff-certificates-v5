import CS31aData.Elab

/-! h = 12 data: part 126 of h12_keys.bin (entries 6303989790 .. 6354021454). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k126 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part126" 400253320 33554432

end CS31aData.H12
