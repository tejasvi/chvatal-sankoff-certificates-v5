import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1049 = cert_data/n13/h13c.vec.part1049, entries 101195972608 .. 101292441599, chunks 24127 .. 24149
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1049 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1049" 385875968 16777216

end CS31aData.N13
