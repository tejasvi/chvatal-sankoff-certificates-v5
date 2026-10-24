import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1601 = cert_data/n13/h13c.vec.part1601, entries 154446856192 .. 154543325183, chunks 36823 .. 36845
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1601 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1601" 385875968 16777216

end CS31aData.N13
