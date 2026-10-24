import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1683 = cert_data/n13/h13c.vec.part1683, entries 162357313536 .. 162453782527, chunks 38709 .. 38731
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1683 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1683" 385875968 16777216

end CS31aData.N13
