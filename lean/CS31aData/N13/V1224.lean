import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1224 = cert_data/n13/h13c.vec.part1224, entries 118078046208 .. 118174515199, chunks 28152 .. 28174
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1224 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1224" 385875968 16777216

end CS31aData.N13
