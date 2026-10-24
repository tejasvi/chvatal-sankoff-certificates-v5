import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1062 = cert_data/n13/h13c.vec.part1062, entries 102450069504 .. 102546538495, chunks 24426 .. 24448
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1062 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1062" 385875968 16777216

end CS31aData.N13
