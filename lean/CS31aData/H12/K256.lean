import CS31aData.Elab

/-! h = 12 data: part 256 of h12_keys.bin (entries 12808106240 .. 12858137904). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k256 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part256" 400253320 33554432

end CS31aData.H12
