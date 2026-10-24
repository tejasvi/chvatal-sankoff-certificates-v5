import CS31aData.Elab

/-! h = 12 data: part 426 of h12_keys.bin (entries 21313489290 .. 21363520954). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k426 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part426" 400253320 33554432

end CS31aData.H12
