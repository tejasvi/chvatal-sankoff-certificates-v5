import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 435 = cert_data/n13/h13c.vec.part0435, entries 41964011520 .. 42060480511, chunks 10005 .. 10027
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v435 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0435" 385875968 16777216

end CS31aData.N13
