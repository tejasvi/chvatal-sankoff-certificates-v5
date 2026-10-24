import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 398 = cert_data/n13/h13c.vec.part0398, entries 38394658816 .. 38491127807, chunks 9154 .. 9176
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v398 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0398" 385875968 16777216

end CS31aData.N13
