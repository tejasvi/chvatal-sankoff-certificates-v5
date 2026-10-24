import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 273 = cert_data/n13/h13c.vec.part0273, entries 26336034816 .. 26432503807, chunks 6279 .. 6301
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v273 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0273" 385875968 16777216

end CS31aData.N13
