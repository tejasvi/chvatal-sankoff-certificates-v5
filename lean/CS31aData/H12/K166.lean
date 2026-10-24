import CS31aData.Elab

/-! h = 12 data: part 166 of h12_keys.bin (entries 8305256390 .. 8355288054). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k166 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part166" 400253320 33554432

end CS31aData.H12
