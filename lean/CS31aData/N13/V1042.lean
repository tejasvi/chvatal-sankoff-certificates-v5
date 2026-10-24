import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1042 = cert_data/n13/h13c.vec.part1042, entries 100520689664 .. 100617158655, chunks 23966 .. 23988
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1042 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1042" 385875968 16777216

end CS31aData.N13
