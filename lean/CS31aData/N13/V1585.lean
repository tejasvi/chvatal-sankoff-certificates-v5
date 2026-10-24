import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1585 = cert_data/n13/h13c.vec.part1585, entries 152903352320 .. 152999821311, chunks 36455 .. 36477
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1585 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1585" 385875968 16777216

end CS31aData.N13
