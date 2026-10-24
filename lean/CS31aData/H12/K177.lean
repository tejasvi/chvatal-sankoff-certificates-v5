import CS31aData.Elab

/-! h = 12 data: part 177 of h12_keys.bin (entries 8855604705 .. 8905636369). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k177 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part177" 400253320 33554432

end CS31aData.H12
