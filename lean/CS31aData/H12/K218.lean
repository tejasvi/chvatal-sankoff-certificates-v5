import CS31aData.Elab

/-! h = 12 data: part 218 of h12_keys.bin (entries 10906902970 .. 10956934634). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k218 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part218" 400253320 33554432

end CS31aData.H12
