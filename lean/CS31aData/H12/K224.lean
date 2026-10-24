import CS31aData.Elab

/-! h = 12 data: part 224 of h12_keys.bin (entries 11207092960 .. 11257124624). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k224 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part224" 400253320 33554432

end CS31aData.H12
