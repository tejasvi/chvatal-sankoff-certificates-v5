import CS31aData.Elab

/-! h = 12 data: part 418 of h12_keys.bin (entries 20913235970 .. 20963267634). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k418 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part418" 400253320 33554432

end CS31aData.H12
