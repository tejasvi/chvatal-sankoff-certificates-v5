import CS31aData.Elab

/-! h = 12 data: part 381 of h12_keys.bin (entries 19062064365 .. 19112096029). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k381 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part381" 400253320 33554432

end CS31aData.H12
