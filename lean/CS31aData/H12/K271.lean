import CS31aData.Elab

/-! h = 12 data: part 271 of h12_keys.bin (entries 13558581215 .. 13608612879). -/

namespace CS31aData.H12

set_option maxHeartbeats 0 in
def k271 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/h12/h12_keys.bin.part271" 400253320 33554432

end CS31aData.H12
