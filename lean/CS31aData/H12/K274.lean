import CS31aData.Elab

/-! h = 12 data: part 274 of h12_keys.bin (entries 13708676210 .. 13758707874). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k274 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part274" 400253320 33554432

end CS31aData.H12
