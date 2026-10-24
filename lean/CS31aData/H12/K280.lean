import CS31aData.Elab

/-! h = 12 data: part 280 of h12_keys.bin (entries 14008866200 .. 14058897864). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k280 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part280" 400253320 33554432

end CS31aData.H12
