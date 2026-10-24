import CS31aData.Elab

/-! h = 12 data: part 29 of h12_keys.bin (entries 1450918285 .. 1500949949). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k29 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part029" 400253320 33554432

end CS31aData.H12
