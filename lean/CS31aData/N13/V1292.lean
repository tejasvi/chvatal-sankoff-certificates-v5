import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1292 = cert_data/n13/h13c.vec.part1292, entries 124637937664 .. 124734406655, chunks 29716 .. 29738
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1292 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1292" 385875968 16777216

end CS31aData.N13
