import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1019 = cert_data/n13/h13c.vec.part1019, entries 98301902848 .. 98398371839, chunks 23437 .. 23459
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1019 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1019" 385875968 16777216

end CS31aData.N13
