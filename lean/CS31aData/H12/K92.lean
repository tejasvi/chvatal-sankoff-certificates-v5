import CS31aData.Elab

/-! h = 12 data: part 92 of h12_keys.bin (entries 4602913180 .. 4652944844). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k92 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part092" 400253320 33554432

end CS31aData.H12
