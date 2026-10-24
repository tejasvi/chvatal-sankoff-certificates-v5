import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1263 = cert_data/n13/h13c.vec.part1263, entries 121840336896 .. 121936805887, chunks 29049 .. 29071
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1263 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1263" 385875968 16777216

end CS31aData.N13
