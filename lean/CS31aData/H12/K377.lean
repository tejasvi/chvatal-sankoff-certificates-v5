import CS31aData.Elab

/-! h = 12 data: part 377 of h12_keys.bin (entries 18861937705 .. 18911969369). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k377 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part377" 400253320 33554432

end CS31aData.H12
