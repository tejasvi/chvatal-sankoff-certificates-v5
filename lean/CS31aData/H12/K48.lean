import CS31aData.Elab

/-! h = 12 data: part 48 of h12_keys.bin (entries 2401519920 .. 2451551584). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k48 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part048" 400253320 33554432

end CS31aData.H12
