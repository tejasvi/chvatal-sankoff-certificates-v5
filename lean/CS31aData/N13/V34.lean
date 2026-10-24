import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 34 = cert_data/n13/h13c.vec.part0034, entries 3279945728 .. 3376414719, chunks 782 .. 804
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v34 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0034" 385875968 16777216

end CS31aData.N13
