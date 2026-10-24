import CS31aData.Elab

/-! h = 12 data: part 9 of h12_keys.bin (entries 450284985 .. 500316649). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k9 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part009" 400253320 33554432

end CS31aData.H12
