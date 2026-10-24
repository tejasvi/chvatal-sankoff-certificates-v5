import CS31aData.Elab

/-! h = 12 data: part 414 of h12_keys.bin (entries 20713109310 .. 20763140974). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k414 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part414" 400253320 33554432

end CS31aData.H12
