import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1378 = cert_data/n13/h13c.vec.part1378, entries 132934270976 .. 133030739967, chunks 31694 .. 31716
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1378 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1378" 385875968 16777216

end CS31aData.N13
