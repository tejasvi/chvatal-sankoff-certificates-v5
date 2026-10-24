import CS31aData.Elab

/-! h = 12 data: part 226 of h12_keys.bin (entries 11307156290 .. 11357187954). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k226 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part226" 400253320 33554432

end CS31aData.H12
