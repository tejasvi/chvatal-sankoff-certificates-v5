import CS31aData.Elab

/-! h = 12 data: part 206 of h12_vdet_0.350500.bin (entries 10306522990 .. 10356554654). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v206 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part206" 400253320 33554432

end CS31aData.H12
