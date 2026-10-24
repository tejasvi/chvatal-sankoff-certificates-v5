import CS31aData.Elab

/-! h = 12 data: part 98 of h12_keys.bin (entries 4903103170 .. 4953134834). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k98 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part098" 400253320 33554432

end CS31aData.H12
