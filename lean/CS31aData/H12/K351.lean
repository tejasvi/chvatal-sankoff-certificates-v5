import CS31aData.Elab

/-! h = 12 data: part 351 of h12_keys.bin (entries 17561114415 .. 17611146079). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k351 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part351" 400253320 33554432

end CS31aData.H12
