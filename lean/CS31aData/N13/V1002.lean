import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1002 = cert_data/n13/h13c.vec.part1002, entries 96661929984 .. 96758398975, chunks 23046 .. 23068
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1002 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1002" 385875968 16777216

end CS31aData.N13
