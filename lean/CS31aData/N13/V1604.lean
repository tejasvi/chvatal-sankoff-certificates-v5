import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1604 = cert_data/n13/h13c.vec.part1604, entries 154736263168 .. 154832732159, chunks 36892 .. 36914
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1604 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1604" 385875968 16777216

end CS31aData.N13
