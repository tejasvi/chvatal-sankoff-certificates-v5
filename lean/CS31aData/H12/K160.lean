import CS31aData.Elab

/-! h = 12 data: part 160 of h12_keys.bin (entries 8005066400 .. 8055098064). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k160 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part160" 400253320 33554432

end CS31aData.H12
