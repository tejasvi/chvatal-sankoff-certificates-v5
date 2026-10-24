import CS31aData.Elab

/-! h = 12 data: part 123 of h12_keys.bin (entries 6153894795 .. 6203926459). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k123 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part123" 400253320 33554432

end CS31aData.H12
