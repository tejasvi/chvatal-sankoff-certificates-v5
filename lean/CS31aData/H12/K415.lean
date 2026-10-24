import CS31aData.Elab

/-! h = 12 data: part 415 of h12_keys.bin (entries 20763140975 .. 20813172639). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k415 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part415" 400253320 33554432

end CS31aData.H12
