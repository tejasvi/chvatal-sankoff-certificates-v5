import CS31aData.Elab

/-! h = 12 data: part 36 of h12_keys.bin (entries 1801139940 .. 1851171604). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k36 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part036" 400253320 33554432

end CS31aData.H12
