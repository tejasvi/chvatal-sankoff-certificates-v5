import CS31aData.Elab

/-! h = 12 data: part 259 of h12_keys.bin (entries 12958201235 .. 13008232899). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k259 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part259" 400253320 33554432

end CS31aData.H12
