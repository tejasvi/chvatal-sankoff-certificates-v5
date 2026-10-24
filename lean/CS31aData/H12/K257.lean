import CS31aData.Elab

/-! h = 12 data: part 257 of h12_keys.bin (entries 12858137905 .. 12908169569). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k257 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part257" 400253320 33554432

end CS31aData.H12
