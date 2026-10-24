import CS31aData.Elab

/-! h = 12 data: part 1 of h12_keys.bin (entries 50031665 .. 100063329). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k1 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part001" 400253320 33554432

end CS31aData.H12
