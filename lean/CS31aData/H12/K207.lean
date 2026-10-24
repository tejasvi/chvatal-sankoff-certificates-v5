import CS31aData.Elab

/-! h = 12 data: part 207 of h12_keys.bin (entries 10356554655 .. 10406586319). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k207 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part207" 400253320 33554432

end CS31aData.H12
