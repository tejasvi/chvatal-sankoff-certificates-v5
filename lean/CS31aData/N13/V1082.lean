import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1082 = cert_data/n13/h13c.vec.part1082, entries 104379449344 .. 104475918335, chunks 24886 .. 24908
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1082 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1082" 385875968 16777216

end CS31aData.N13
