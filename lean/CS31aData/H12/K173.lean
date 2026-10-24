import CS31aData.Elab

/-! h = 12 data: part 173 of h12_keys.bin (entries 8655478045 .. 8705509709). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k173 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part173" 400253320 33554432

end CS31aData.H12
