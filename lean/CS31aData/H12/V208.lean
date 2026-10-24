import CS31aData.Elab

/-! h = 12 data: part 208 of h12_vdet_0.350500.bin (entries 10406586320 .. 10456617984). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v208 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part208" 400253320 33554432

end CS31aData.H12
