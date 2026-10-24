import CS31aData.Elab

/-! h = 12 data: part 85 of h12_keys.bin (entries 4252691525 .. 4302723189). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k85 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part085" 400253320 33554432

end CS31aData.H12
