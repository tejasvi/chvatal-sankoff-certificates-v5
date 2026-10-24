import CS31aData.Elab

/-! h = 12 data: part 79 of h12_keys.bin (entries 3952501535 .. 4002533199). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k79 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part079" 400253320 33554432

end CS31aData.H12
