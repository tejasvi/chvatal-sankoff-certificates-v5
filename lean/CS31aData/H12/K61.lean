import CS31aData.Elab

/-! h = 12 data: part 61 of h12_keys.bin (entries 3051931565 .. 3101963229). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k61 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part061" 400253320 33554432

end CS31aData.H12
