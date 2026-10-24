import CS31aData.Elab

/-! h = 12 data: part 290 of h12_keys.bin (entries 14509182850 .. 14559214514). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k290 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part290" 400253320 33554432

end CS31aData.H12
