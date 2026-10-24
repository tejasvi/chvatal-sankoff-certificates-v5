import CS31aData.Elab

/-! h = 12 data: part 424 of h12_keys.bin (entries 21213425960 .. 21263457624). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k424 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part424" 400253320 33554432

end CS31aData.H12
