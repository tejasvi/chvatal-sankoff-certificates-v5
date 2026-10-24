import CS31aData.Elab

/-! h = 12 data: part 287 of h12_keys.bin (entries 14359087855 .. 14409119519). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k287 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part287" 400253320 33554432

end CS31aData.H12
