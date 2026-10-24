import CS31aData.Elab

/-! h = 12 data: part 216 of h12_keys.bin (entries 10806839640 .. 10856871304). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k216 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part216" 400253320 33554432

end CS31aData.H12
