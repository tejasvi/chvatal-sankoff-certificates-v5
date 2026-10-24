import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1341 = cert_data/n13/h13c.vec.part1341, entries 129364918272 .. 129461387263, chunks 30843 .. 30865
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1341 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1341" 385875968 16777216

end CS31aData.N13
