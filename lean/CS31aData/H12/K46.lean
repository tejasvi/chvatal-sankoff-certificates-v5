import CS31aData.Elab

/-! h = 12 data: part 46 of h12_keys.bin (entries 2301456590 .. 2351488254). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k46 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part046" 400253320 33554432

end CS31aData.H12
