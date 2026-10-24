import CS31aData.Elab

/-! h = 12 data: part 298 of h12_keys.bin (entries 14909436170 .. 14959467834). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k298 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part298" 400253320 33554432

end CS31aData.H12
