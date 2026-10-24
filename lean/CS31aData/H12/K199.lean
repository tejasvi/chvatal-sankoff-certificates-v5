import CS31aData.Elab

/-! h = 12 data: part 199 of h12_keys.bin (entries 9956301335 .. 10006332999). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k199 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part199" 400253320 33554432

end CS31aData.H12
