import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1297 = cert_data/n13/h13c.vec.part1297, entries 125120282624 .. 125216751615, chunks 29831 .. 29853
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1297 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1297" 385875968 16777216

end CS31aData.N13
