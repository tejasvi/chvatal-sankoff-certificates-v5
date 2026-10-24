import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1609 = cert_data/n13/h13c.vec.part1609, entries 155218608128 .. 155315077119, chunks 37007 .. 37029
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1609 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1609" 385875968 16777216

end CS31aData.N13
