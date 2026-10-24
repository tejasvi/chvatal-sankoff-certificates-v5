import CS31aData.Elab

/-! h = 12 data: part 230 of h12_keys.bin (entries 11507282950 .. 11557314614). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k230 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part230" 400253320 33554432

end CS31aData.H12
