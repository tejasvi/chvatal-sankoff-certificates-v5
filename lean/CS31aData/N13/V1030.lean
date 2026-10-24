import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1030 = cert_data/n13/h13c.vec.part1030, entries 99363061760 .. 99459530751, chunks 23690 .. 23712
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1030 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1030" 385875968 16777216

end CS31aData.N13
