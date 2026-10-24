import CS31aData.Elab

/-! h = 12 data: part 258 of h12_keys.bin (entries 12908169570 .. 12958201234). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k258 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part258" 400253320 33554432

end CS31aData.H12
