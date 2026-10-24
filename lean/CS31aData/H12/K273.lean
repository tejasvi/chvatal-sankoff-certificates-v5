import CS31aData.Elab

/-! h = 12 data: part 273 of h12_keys.bin (entries 13658644545 .. 13708676209). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k273 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part273" 400253320 33554432

end CS31aData.H12
