import CS31aData.Elab

/-! h = 12 data: part 39 of h12_keys.bin (entries 1951234935 .. 2001266599). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k39 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part039" 400253320 33554432

end CS31aData.H12
