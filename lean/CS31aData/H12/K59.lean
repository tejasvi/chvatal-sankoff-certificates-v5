import CS31aData.Elab

/-! h = 12 data: part 59 of h12_keys.bin (entries 2951868235 .. 3001899899). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k59 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part059" 400253320 33554432

end CS31aData.H12
