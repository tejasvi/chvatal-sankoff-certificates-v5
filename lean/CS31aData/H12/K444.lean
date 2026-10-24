import CS31aData.Elab

/-! h = 12 data: part 444 of h12_keys.bin (entries 22214059260 .. 22264090924). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k444 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part444" 400253320 33554432

end CS31aData.H12
