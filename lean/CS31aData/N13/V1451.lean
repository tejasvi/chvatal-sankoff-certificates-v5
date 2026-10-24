import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1451 = cert_data/n13/h13c.vec.part1451, entries 139976507392 .. 140072976383, chunks 33373 .. 33395
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1451 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1451" 385875968 16777216

end CS31aData.N13
