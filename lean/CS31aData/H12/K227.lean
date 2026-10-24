import CS31aData.Elab

/-! h = 12 data: part 227 of h12_keys.bin (entries 11357187955 .. 11407219619). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k227 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part227" 400253320 33554432

end CS31aData.H12
