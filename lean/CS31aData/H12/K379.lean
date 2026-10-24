import CS31aData.Elab

/-! h = 12 data: part 379 of h12_keys.bin (entries 18962001035 .. 19012032699). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k379 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part379" 400253320 33554432

end CS31aData.H12
