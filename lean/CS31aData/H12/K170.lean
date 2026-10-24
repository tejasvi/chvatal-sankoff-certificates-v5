import CS31aData.Elab

/-! h = 12 data: part 170 of h12_keys.bin (entries 8505383050 .. 8555414714). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k170 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part170" 400253320 33554432

end CS31aData.H12
