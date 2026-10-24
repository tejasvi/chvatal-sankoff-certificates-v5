import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1309 = cert_data/n13/h13c.vec.part1309, entries 126277910528 .. 126374379519, chunks 30107 .. 30129
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1309 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1309" 385875968 16777216

end CS31aData.N13
