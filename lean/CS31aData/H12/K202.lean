import CS31aData.Elab

/-! h = 12 data: part 202 of h12_keys.bin (entries 10106396330 .. 10156427994). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k202 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part202" 400253320 33554432

end CS31aData.H12
