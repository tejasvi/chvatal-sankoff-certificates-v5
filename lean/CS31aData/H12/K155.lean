import CS31aData.Elab

/-! h = 12 data: part 155 of h12_keys.bin (entries 7754908075 .. 7804939739). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k155 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part155" 400253320 33554432

end CS31aData.H12
