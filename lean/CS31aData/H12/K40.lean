import CS31aData.Elab

/-! h = 12 data: part 40 of h12_keys.bin (entries 2001266600 .. 2051298264). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k40 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part040" 400253320 33554432

end CS31aData.H12
