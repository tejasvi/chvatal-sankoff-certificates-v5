import CS31aData.Elab

/-! h = 12 data: part 263 of h12_keys.bin (entries 13158327895 .. 13208359559). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k263 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part263" 400253320 33554432

end CS31aData.H12
