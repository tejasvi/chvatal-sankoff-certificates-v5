import CS31aData.Elab

/-! h = 12 data: part 286 of h12_keys.bin (entries 14309056190 .. 14359087854). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k286 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part286" 400253320 33554432

end CS31aData.H12
