import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1479 = cert_data/n13/h13c.vec.part1479, entries 142677639168 .. 142774108159, chunks 34017 .. 34039
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1479 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1479" 385875968 16777216

end CS31aData.N13
