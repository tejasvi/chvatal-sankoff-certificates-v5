import CS31aData.Elab

/-! h = 12 data: part 107 of h12_keys.bin (entries 5353388155 .. 5403419819). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k107 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part107" 400253320 33554432

end CS31aData.H12
