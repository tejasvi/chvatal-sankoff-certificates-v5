import CS31aData.Elab

/-! h = 12 data: part 200 of h12_keys.bin (entries 10006333000 .. 10056364664). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k200 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part200" 400253320 33554432

end CS31aData.H12
