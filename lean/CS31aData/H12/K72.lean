import CS31aData.Elab

/-! h = 12 data: part 72 of h12_keys.bin (entries 3602279880 .. 3652311544). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k72 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part072" 400253320 33554432

end CS31aData.H12
