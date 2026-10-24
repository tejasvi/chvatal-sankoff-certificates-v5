import CS31aData.Elab

/-! h = 12 data: part 335 of h12_vdet_0.350500.bin (entries 16760607775 .. 16810639439). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v335 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part335" 400253320 33554432

end CS31aData.H12
