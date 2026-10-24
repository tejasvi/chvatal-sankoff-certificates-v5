import CS31aData.Elab

/-! h = 12 data: part 165 of h12_keys.bin (entries 8255224725 .. 8305256389). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k165 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part165" 400253320 33554432

end CS31aData.H12
