import CS31aData.Elab

/-! h = 12 data: part 329 of h12_keys.bin (entries 16460417785 .. 16510449449). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k329 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part329" 400253320 33554432

end CS31aData.H12
