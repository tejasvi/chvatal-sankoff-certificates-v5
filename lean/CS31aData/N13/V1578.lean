import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1578 = cert_data/n13/h13c.vec.part1578, entries 152228069376 .. 152324538367, chunks 36294 .. 36316
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1578 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1578" 385875968 16777216

end CS31aData.N13
