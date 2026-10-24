import CS31aData.Elab

/-! h = 12 data: part 445 of h12_vdet_0.350500.bin (entries 22264090925 .. 22314122589). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v445 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part445" 400253320 33554432

end CS31aData.H12
