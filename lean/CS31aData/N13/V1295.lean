import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1295 = cert_data/n13/h13c.vec.part1295, entries 124927344640 .. 125023813631, chunks 29785 .. 29807
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1295 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1295" 385875968 16777216

end CS31aData.N13
