import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1505 = cert_data/n13/h13c.vec.part1505, entries 145185832960 .. 145282301951, chunks 34615 .. 34637
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1505 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1505" 385875968 16777216

end CS31aData.N13
