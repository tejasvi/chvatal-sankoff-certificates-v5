import CS31aData.Elab

/-! h = 12 data: part 439 of h12_keys.bin (entries 21963900935 .. 22013932599). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k439 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part439" 400253320 33554432

end CS31aData.H12
