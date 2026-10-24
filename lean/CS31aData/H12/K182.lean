import CS31aData.Elab

/-! h = 12 data: part 182 of h12_keys.bin (entries 9105763030 .. 9155794694). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k182 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part182" 400253320 33554432

end CS31aData.H12
