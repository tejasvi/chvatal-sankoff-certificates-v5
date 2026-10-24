import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1548 = cert_data/n13/h13c.vec.part1548, entries 149333999616 .. 149430468607, chunks 35604 .. 35626
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1548 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1548" 385875968 16777216

end CS31aData.N13
