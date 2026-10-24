import CS31aData.Elab

/-! h = 12 data: part 120 of h12_keys.bin (entries 6003799800 .. 6053831464). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k120 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part120" 400253320 33554432

end CS31aData.H12
