import CS31aData.Elab

/-! h = 12 data: part 156 of h12_keys.bin (entries 7804939740 .. 7854971404). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k156 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part156" 400253320 33554432

end CS31aData.H12
