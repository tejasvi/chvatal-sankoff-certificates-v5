import CS31aData.Elab

/-! h = 12 data: part 267 of h12_keys.bin (entries 13358454555 .. 13408486219). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k267 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part267" 400253320 33554432

end CS31aData.H12
