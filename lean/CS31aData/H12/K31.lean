import CS31aData.Elab

/-! h = 12 data: part 31 of h12_keys.bin (entries 1550981615 .. 1601013279). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k31 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part031" 400253320 33554432

end CS31aData.H12
