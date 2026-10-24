import CS31aData.Elab

/-! h = 12 data: part 190 of h12_keys.bin (entries 9506016350 .. 9556048014). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k190 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part190" 400253320 33554432

end CS31aData.H12
