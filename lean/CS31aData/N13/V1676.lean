import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1676 = cert_data/n13/h13c.vec.part1676, entries 161682030592 .. 161778499583, chunks 38548 .. 38570
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1676 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1676" 385875968 16777216

end CS31aData.N13
