import CS31aData.Elab

/-! h = 12 data: part 320 of h12_keys.bin (entries 16010132800 .. 16060164464). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k320 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part320" 400253320 33554432

end CS31aData.H12
