import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1313 = cert_data/n13/h13c.vec.part1313, entries 126663786496 .. 126760255487, chunks 30199 .. 30221
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1313 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1313" 385875968 16777216

end CS31aData.N13
