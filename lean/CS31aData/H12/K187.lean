import CS31aData.Elab

/-! h = 12 data: part 187 of h12_keys.bin (entries 9355921355 .. 9405953019). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k187 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part187" 400253320 33554432

end CS31aData.H12
