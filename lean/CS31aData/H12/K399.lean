import CS31aData.Elab

/-! h = 12 data: part 399 of h12_keys.bin (entries 19962634335 .. 20012665999). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k399 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part399" 400253320 33554432

end CS31aData.H12
