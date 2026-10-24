import CS31aData.Elab

/-! h = 12 data: part 451 of h12_keys.bin (entries 22564280915 .. 22614312579). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k451 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part451" 400253320 33554432

end CS31aData.H12
