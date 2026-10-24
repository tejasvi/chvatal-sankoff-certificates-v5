import CS31aData.Elab

/-! h = 12 data: part 149 of h12_keys.bin (entries 7454718085 .. 7504749749). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k149 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part149" 400253320 33554432

end CS31aData.H12
