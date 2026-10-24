import CS31aData.Elab

/-! h = 12 data: part 266 of h12_keys.bin (entries 13308422890 .. 13358454554). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k266 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part266" 400253320 33554432

end CS31aData.H12
