import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1462 = cert_data/n13/h13c.vec.part1462, entries 141037666304 .. 141134135295, chunks 33626 .. 33648
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1462 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1462" 385875968 16777216

end CS31aData.N13
