import CS31aData.Elab

/-! h = 12 data: part 41 of h12_keys.bin (entries 2051298265 .. 2101329929). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k41 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part041" 400253320 33554432

end CS31aData.H12
