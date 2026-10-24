import CS31aData.Elab

/-! h = 12 data: part 312 of h12_keys.bin (entries 15609879480 .. 15659911144). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k312 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part312" 400253320 33554432

end CS31aData.H12
