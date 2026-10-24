import CS31aData.Elab

/-! h = 12 data: part 328 of h12_keys.bin (entries 16410386120 .. 16460417784). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k328 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part328" 400253320 33554432

end CS31aData.H12
