import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1454 = cert_data/n13/h13c.vec.part1454, entries 140265914368 .. 140362383359, chunks 33442 .. 33464
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1454 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1454" 385875968 16777216

end CS31aData.N13
