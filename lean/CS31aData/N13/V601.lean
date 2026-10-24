import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 601 = cert_data/n13/h13c.vec.part0601, entries 57977864192 .. 58074333183, chunks 13823 .. 13845
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v601 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0601" 385875968 16777216

end CS31aData.N13
