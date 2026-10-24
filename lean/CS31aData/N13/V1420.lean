import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1420 = cert_data/n13/h13c.vec.part1420, entries 136985968640 .. 137082437631, chunks 32660 .. 32682
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1420 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1420" 385875968 16777216

end CS31aData.N13
