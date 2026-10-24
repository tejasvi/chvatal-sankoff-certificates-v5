import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 330 = cert_data/n13/h13c.vec.part0330, entries 31834767360 .. 31931236351, chunks 7590 .. 7612
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v330 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0330" 385875968 16777216

end CS31aData.N13
