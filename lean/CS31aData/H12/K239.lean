import CS31aData.Elab

/-! h = 12 data: part 239 of h12_keys.bin (entries 11957567935 .. 12007599599). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k239 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part239" 400253320 33554432

end CS31aData.H12
