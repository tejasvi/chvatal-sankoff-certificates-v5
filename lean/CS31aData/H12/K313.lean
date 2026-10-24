import CS31aData.Elab

/-! h = 12 data: part 313 of h12_keys.bin (entries 15659911145 .. 15709942809). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k313 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part313" 400253320 33554432

end CS31aData.H12
