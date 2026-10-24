import CS31aData.Elab

/-! h = 12 data: part 371 of h12_keys.bin (entries 18561747715 .. 18611779379). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k371 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part371" 400253320 33554432

end CS31aData.H12
