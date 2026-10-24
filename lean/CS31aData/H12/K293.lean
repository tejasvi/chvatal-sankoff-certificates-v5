import CS31aData.Elab

/-! h = 12 data: part 293 of h12_keys.bin (entries 14659277845 .. 14709309509). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k293 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part293" 400253320 33554432

end CS31aData.H12
