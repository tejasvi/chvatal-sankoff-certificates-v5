import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1584 = cert_data/n13/h13c.vec.part1584, entries 152806883328 .. 152903352319, chunks 36432 .. 36454
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1584 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1584" 385875968 16777216

end CS31aData.N13
