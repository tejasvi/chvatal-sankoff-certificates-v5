import CS31aData.Elab

/-! h = 12 data: part 325 of h12_keys.bin (entries 16260291125 .. 16310322789). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k325 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part325" 400253320 33554432

end CS31aData.H12
