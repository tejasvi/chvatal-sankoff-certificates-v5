import CS31aData.Elab

/-! h = 12 data: part 292 of h12_keys.bin (entries 14609246180 .. 14659277844). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k292 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part292" 400253320 33554432

end CS31aData.H12
