import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1240 = cert_data/n13/h13c.vec.part1240, entries 119621550080 .. 119718019071, chunks 28520 .. 28542
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1240 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1240" 385875968 16777216

end CS31aData.N13
