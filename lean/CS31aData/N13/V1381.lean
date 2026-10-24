import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1381 = cert_data/n13/h13c.vec.part1381, entries 133223677952 .. 133320146943, chunks 31763 .. 31785
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1381 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1381" 385875968 16777216

end CS31aData.N13
