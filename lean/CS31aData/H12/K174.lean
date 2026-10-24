import CS31aData.Elab

/-! h = 12 data: part 174 of h12_keys.bin (entries 8705509710 .. 8755541374). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k174 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part174" 400253320 33554432

end CS31aData.H12
