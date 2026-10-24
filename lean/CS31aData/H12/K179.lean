import CS31aData.Elab

/-! h = 12 data: part 179 of h12_keys.bin (entries 8955668035 .. 9005699699). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k179 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part179" 400253320 33554432

end CS31aData.H12
