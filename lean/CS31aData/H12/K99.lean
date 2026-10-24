import CS31aData.Elab

/-! h = 12 data: part 99 of h12_keys.bin (entries 4953134835 .. 5003166499). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k99 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part099" 400253320 33554432

end CS31aData.H12
