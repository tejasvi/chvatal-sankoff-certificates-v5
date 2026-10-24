import CS31aData.Elab

/-! h = 12 data: part 251 of h12_keys.bin (entries 12557947915 .. 12607979579). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k251 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part251" 400253320 33554432

end CS31aData.H12
