import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1521 = cert_data/n13/h13c.vec.part1521, entries 146729336832 .. 146825805823, chunks 34983 .. 35005
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1521 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1521" 385875968 16777216

end CS31aData.N13
