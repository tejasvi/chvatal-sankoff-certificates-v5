import CS31aData.Elab

/-! h = 12 data: part 64 of h12_keys.bin (entries 3202026560 .. 3252058224). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k64 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part064" 400253320 33554432

end CS31aData.H12
