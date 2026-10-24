import CS31aData.Elab

/-! h = 12 data: part 345 of h12_keys.bin (entries 17260924425 .. 17310956089). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k345 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part345" 400253320 33554432

end CS31aData.H12
