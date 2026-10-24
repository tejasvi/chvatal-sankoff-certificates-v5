import CS31aData.Elab

/-! h = 12 data: part 449 of h12_keys.bin (entries 22464217585 .. 22514249249). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k449 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part449" 400253320 33554432

end CS31aData.H12
