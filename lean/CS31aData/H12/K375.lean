import CS31aData.Elab

/-! h = 12 data: part 375 of h12_keys.bin (entries 18761874375 .. 18811906039). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k375 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part375" 400253320 33554432

end CS31aData.H12
