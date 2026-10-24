import CS31aData.Elab

/-! h = 12 data: part 386 of h12_keys.bin (entries 19312222690 .. 19362254354). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k386 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part386" 400253320 33554432

end CS31aData.H12
