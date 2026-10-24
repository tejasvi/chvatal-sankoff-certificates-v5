import CS31aData.Elab

/-! h = 12 data: part 242 of h12_keys.bin (entries 12107662930 .. 12157694594). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k242 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part242" 400253320 33554432

end CS31aData.H12
