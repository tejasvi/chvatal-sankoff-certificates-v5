import CS31aData.Elab

/-! h = 12 data: part 382 of h12_keys.bin (entries 19112096030 .. 19162127694). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k382 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part382" 400253320 33554432

end CS31aData.H12
