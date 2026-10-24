import CS31aData.Elab

/-! h = 12 data: part 380 of h12_vdet_0.350500.bin (entries 19012032700 .. 19062064364). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def v380 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_vdet_0.350500.bin.part380" 400253320 33554432

end CS31aData.H12
