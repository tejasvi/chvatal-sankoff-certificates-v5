import CS31aData.Elab

/-! h = 12 data: part 333 of h12_keys.bin (entries 16660544445 .. 16710576109). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k333 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part333" 400253320 33554432

end CS31aData.H12
