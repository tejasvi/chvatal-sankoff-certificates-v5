import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 261 = cert_data/n13/h13c.vec.part0261, entries 25178406912 .. 25274875903, chunks 6003 .. 6025
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v261 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0261" 385875968 16777216

end CS31aData.N13
