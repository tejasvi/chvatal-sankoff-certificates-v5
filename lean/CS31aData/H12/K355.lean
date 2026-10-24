import CS31aData.Elab

/-! h = 12 data: part 355 of h12_keys.bin (entries 17761241075 .. 17811272739). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k355 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part355" 400253320 33554432

end CS31aData.H12
