import CS31aData.Elab

/-! h = 12 data: part 110 of h12_keys.bin (entries 5503483150 .. 5553514814). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k110 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part110" 400253320 33554432

end CS31aData.H12
