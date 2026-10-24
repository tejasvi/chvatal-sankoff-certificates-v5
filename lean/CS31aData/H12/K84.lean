import CS31aData.Elab

/-! h = 12 data: part 84 of h12_keys.bin (entries 4202659860 .. 4252691524). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k84 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part084" 400253320 33554432

end CS31aData.H12
