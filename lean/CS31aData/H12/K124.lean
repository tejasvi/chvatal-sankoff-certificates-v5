import CS31aData.Elab

/-! h = 12 data: part 124 of h12_keys.bin (entries 6203926460 .. 6253958124). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k124 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part124" 400253320 33554432

end CS31aData.H12
