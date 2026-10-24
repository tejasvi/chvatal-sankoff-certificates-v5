import CS31aData.Elab

/-! h = 12 data: part 104 of h12_keys.bin (entries 5203293160 .. 5253324824). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k104 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part104" 400253320 33554432

end CS31aData.H12
