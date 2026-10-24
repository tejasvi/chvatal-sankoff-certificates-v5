import CS31aData.Elab

/-! h = 12 data: part 430 of h12_keys.bin (entries 21513615950 .. 21563647614). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k430 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part430" 400253320 33554432

end CS31aData.H12
