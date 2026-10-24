import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1551 = cert_data/n13/h13c.vec.part1551, entries 149623406592 .. 149719875583, chunks 35673 .. 35695
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1551 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1551" 385875968 16777216

end CS31aData.N13
