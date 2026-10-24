import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 913 = cert_data/n13/h13c.vec.part0913, entries 88076189696 .. 88172658687, chunks 20999 .. 21021
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v913 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0913" 385875968 16777216

end CS31aData.N13
