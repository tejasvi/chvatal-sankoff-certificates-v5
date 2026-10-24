import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 602 = cert_data/n13/h13c.vec.part0602, entries 58074333184 .. 58170802175, chunks 13846 .. 13868
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v602 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part0602" 385875968 16777216

end CS31aData.N13
