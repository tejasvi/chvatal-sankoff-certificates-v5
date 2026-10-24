import CS31aData.Elab

/-! h = 12 data: part 212 of h12_keys.bin (entries 10606712980 .. 10656744644). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k212 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part212" 400253320 33554432

end CS31aData.H12
