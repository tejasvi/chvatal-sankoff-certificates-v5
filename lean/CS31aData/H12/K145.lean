import CS31aData.Elab

/-! h = 12 data: part 145 of h12_keys.bin (entries 7254591425 .. 7304623089). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k145 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part145" 400253320 33554432

end CS31aData.H12
