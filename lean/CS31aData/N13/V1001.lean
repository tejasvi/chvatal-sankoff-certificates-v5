import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1001 = cert_data/n13/h13c.vec.part1001, entries 96565460992 .. 96661929983, chunks 23023 .. 23045
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1001 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1001" 385875968 16777216

end CS31aData.N13
