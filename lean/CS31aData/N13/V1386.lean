import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1386 = cert_data/n13/h13c.vec.part1386, entries 133706022912 .. 133802491903, chunks 31878 .. 31900
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1386 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1386" 385875968 16777216

end CS31aData.N13
