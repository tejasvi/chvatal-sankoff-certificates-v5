import CS31aData.Elab

/-! h = 12 data: part 71 of h12_keys.bin (entries 3552248215 .. 3602279879). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k71 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part071" 400253320 33554432

end CS31aData.H12
