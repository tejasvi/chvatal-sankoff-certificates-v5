import CS31aData.Elab

/-! h = 12 data: part 340 of h12_keys.bin (entries 17010766100 .. 17060797764). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k340 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part340" 400253320 33554432

end CS31aData.H12
