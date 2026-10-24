import CS31aData.Elab

/-! h = 12 data: part 434 of h12_keys.bin (entries 21713742610 .. 21763774274). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k434 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part434" 400253320 33554432

end CS31aData.H12
