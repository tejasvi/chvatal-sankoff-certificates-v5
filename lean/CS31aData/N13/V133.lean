import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 133 = cert_data/n13/h13c.vec.part0133, entries 12830375936 .. 12926844927, chunks 3059 .. 3081
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v133 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0133" 385875968 16777216

end CS31aData.N13
