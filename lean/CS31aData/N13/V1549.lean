import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1549 = cert_data/n13/h13c.vec.part1549, entries 149430468608 .. 149526937599, chunks 35627 .. 35649
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1549 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1549" 385875968 16777216

end CS31aData.N13
