import CS31aData.Elab

/-! h = 12 data: part 180 of h12_vdet_0.350500.bin (entries 9005699700 .. 9055731364). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v180 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part180" 400253320 33554432

end CS31aData.H12
