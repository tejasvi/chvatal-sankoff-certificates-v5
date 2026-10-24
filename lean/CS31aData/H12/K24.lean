import CS31aData.Elab

/-! h = 12 data: part 24 of h12_keys.bin (entries 1200759960 .. 1250791624). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k24 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part024" 400253320 33554432

end CS31aData.H12
