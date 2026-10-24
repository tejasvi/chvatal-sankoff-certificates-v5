import CS31aData.Elab

/-! h = 12 data: part 196 of h12_keys.bin (entries 9806206340 .. 9856238004). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k196 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part196" 400253320 33554432

end CS31aData.H12
