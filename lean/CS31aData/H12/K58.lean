import CS31aData.Elab

/-! h = 12 data: part 58 of h12_keys.bin (entries 2901836570 .. 2951868234). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k58 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part058" 400253320 33554432

end CS31aData.H12
