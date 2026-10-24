import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 636 = cert_data/n13/h13c.vec.part0636, entries 61354278912 .. 61450747903, chunks 14628 .. 14650
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v636 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0636" 385875968 16777216

end CS31aData.N13
