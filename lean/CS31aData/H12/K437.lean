import CS31aData.Elab

/-! h = 12 data: part 437 of h12_keys.bin (entries 21863837605 .. 21913869269). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k437 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part437" 400253320 33554432

end CS31aData.H12
