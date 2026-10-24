import CS31aData.Elab

/-! h = 12 data: part 438 of h12_keys.bin (entries 21913869270 .. 21963900934). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k438 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part438" 400253320 33554432

end CS31aData.H12
