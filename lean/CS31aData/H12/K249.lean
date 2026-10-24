import CS31aData.Elab

/-! h = 12 data: part 249 of h12_keys.bin (entries 12457884585 .. 12507916249). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k249 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part249" 400253320 33554432

end CS31aData.H12
