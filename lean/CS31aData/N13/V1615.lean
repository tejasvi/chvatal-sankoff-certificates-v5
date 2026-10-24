import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1615 = cert_data/n13/h13c.vec.part1615, entries 155797422080 .. 155893891071, chunks 37145 .. 37167
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1615 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1615" 385875968 16777216

end CS31aData.N13
