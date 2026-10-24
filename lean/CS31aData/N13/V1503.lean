import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1503 = cert_data/n13/h13c.vec.part1503, entries 144992894976 .. 145089363967, chunks 34569 .. 34591
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1503 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1503" 385875968 16777216

end CS31aData.N13
