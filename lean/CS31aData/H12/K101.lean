import CS31aData.Elab

/-! h = 12 data: part 101 of h12_keys.bin (entries 5053198165 .. 5103229829). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k101 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part101" 400253320 33554432

end CS31aData.H12
