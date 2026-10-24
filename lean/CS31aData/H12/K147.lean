import CS31aData.Elab

/-! h = 12 data: part 147 of h12_keys.bin (entries 7354654755 .. 7404686419). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k147 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part147" 400253320 33554432

end CS31aData.H12
