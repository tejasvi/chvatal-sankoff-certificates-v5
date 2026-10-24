import CS31aData.Elab

/-! h = 12 data: part 83 of h12_keys.bin (entries 4152628195 .. 4202659859). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k83 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part083" 400253320 33554432

end CS31aData.H12
