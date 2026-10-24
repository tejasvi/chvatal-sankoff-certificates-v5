import CS31aData.Elab

/-! h = 12 data: part 448 of h12_keys.bin (entries 22414185920 .. 22464217584). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k448 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part448" 400253320 33554432

end CS31aData.H12
