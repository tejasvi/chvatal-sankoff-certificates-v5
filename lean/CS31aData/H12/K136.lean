import CS31aData.Elab

/-! h = 12 data: part 136 of h12_keys.bin (entries 6804306440 .. 6854338104). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k136 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part136" 400253320 33554432

end CS31aData.H12
