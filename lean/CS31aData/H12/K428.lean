import CS31aData.Elab

/-! h = 12 data: part 428 of h12_keys.bin (entries 21413552620 .. 21463584284). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k428 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part428" 400253320 33554432

end CS31aData.H12
