import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1262 = cert_data/n13/h13c.vec.part1262, entries 121743867904 .. 121840336895, chunks 29026 .. 29048
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1262 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1262" 385875968 16777216

end CS31aData.N13
