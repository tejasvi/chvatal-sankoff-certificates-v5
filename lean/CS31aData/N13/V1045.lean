import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1045 = cert_data/n13/h13c.vec.part1045, entries 100810096640 .. 100906565631, chunks 24035 .. 24057
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1045 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1045" 385875968 16777216

end CS31aData.N13
