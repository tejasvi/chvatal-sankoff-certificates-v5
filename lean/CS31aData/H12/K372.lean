import CS31aData.Elab

/-! h = 12 data: part 372 of h12_keys.bin (entries 18611779380 .. 18661811044). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k372 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part372" 400253320 33554432

end CS31aData.H12
