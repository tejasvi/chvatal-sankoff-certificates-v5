import CS31aData.Elab

/-! h = 12 data: part 204 of h12_keys.bin (entries 10206459660 .. 10256491324). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k204 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part204" 400253320 33554432

end CS31aData.H12
