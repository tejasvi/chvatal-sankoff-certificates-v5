import CS31aData.Elab

/-! h = 12 data: part 211 of h12_keys.bin (entries 10556681315 .. 10606712979). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k211 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part211" 400253320 33554432

end CS31aData.H12
