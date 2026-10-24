import CS31aData.Elab

/-! h = 12 data: part 189 of h12_keys.bin (entries 9455984685 .. 9506016349). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k189 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part189" 400253320 33554432

end CS31aData.H12
