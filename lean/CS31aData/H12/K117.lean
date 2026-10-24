import CS31aData.Elab

/-! h = 12 data: part 117 of h12_keys.bin (entries 5853704805 .. 5903736469). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k117 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part117" 400253320 33554432

end CS31aData.H12
