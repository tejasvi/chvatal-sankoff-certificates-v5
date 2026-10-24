import CS31aData.Elab

/-! h = 12 data: part 301 of h12_vdet_0.350500.bin (entries 15059531165 .. 15109562829). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v301 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part301" 400253320 33554432

end CS31aData.H12
