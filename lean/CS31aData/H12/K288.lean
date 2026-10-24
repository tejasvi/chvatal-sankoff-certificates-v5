import CS31aData.Elab

/-! h = 12 data: part 288 of h12_keys.bin (entries 14409119520 .. 14459151184). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k288 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part288" 400253320 33554432

end CS31aData.H12
