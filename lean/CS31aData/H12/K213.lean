import CS31aData.Elab

/-! h = 12 data: part 213 of h12_keys.bin (entries 10656744645 .. 10706776309). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k213 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part213" 400253320 33554432

end CS31aData.H12
