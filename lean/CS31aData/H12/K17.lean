import CS31aData.Elab

/-! h = 12 data: part 17 of h12_keys.bin (entries 850538305 .. 900569969). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k17 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part017" 400253320 33554432

end CS31aData.H12
