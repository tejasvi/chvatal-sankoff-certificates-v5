import CS31aData.Elab

/-! h = 12 data: part 69 of h12_keys.bin (entries 3452184885 .. 3502216549). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k69 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part069" 400253320 33554432

end CS31aData.H12
