import CS31aData.Elab

/-! h = 12 data: part 420 of h12_keys.bin (entries 21013299300 .. 21063330964). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k420 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part420" 400253320 33554432

end CS31aData.H12
