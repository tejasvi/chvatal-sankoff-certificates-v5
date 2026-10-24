import CS31aData.Elab

/-! h = 12 data: part 331 of h12_keys.bin (entries 16560481115 .. 16610512779). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k331 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part331" 400253320 33554432

end CS31aData.H12
