import CS31aData.Elab

/-! h = 12 data: part 60 of h12_keys.bin (entries 3001899900 .. 3051931564). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k60 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part060" 400253320 33554432

end CS31aData.H12
