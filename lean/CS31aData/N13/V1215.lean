import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1215 = cert_data/n13/h13c.vec.part1215, entries 117209825280 .. 117306294271, chunks 27945 .. 27967
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1215 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1215" 385875968 16777216

end CS31aData.N13
