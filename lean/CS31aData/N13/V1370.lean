import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1370 = cert_data/n13/h13c.vec.part1370, entries 132162519040 .. 132258988031, chunks 31510 .. 31532
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1370 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1370" 385875968 16777216

end CS31aData.N13
