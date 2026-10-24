import CS31aData.Elab

/-! h = 12 data: part 95 of h12_keys.bin (entries 4753008175 .. 4803039839). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k95 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part095" 400253320 33554432

end CS31aData.H12
