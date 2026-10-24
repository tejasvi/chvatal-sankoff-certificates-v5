import CS31aData.Elab

/-! h = 12 data: part 248 of h12_keys.bin (entries 12407852920 .. 12457884584). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k248 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part248" 400253320 33554432

end CS31aData.H12
