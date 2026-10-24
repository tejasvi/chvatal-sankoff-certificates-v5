import CS31aData.Elab

/-! h = 12 data: part 350 of h12_keys.bin (entries 17511082750 .. 17561114414). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k350 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part350" 400253320 33554432

end CS31aData.H12
