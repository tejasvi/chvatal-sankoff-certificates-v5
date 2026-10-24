import CS31aData.Elab

/-! h = 12 data: part 73 of h12_keys.bin (entries 3652311545 .. 3702343209). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k73 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part073" 400253320 33554432

end CS31aData.H12
