import CS31aData.Elab

/-! h = 12 data: part 183 of h12_keys.bin (entries 9155794695 .. 9205826359). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k183 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part183" 400253320 33554432

end CS31aData.H12
