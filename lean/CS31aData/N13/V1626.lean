import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1626 = cert_data/n13/h13c.vec.part1626, entries 156858580992 .. 156955049983, chunks 37398 .. 37420
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1626 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1626" 385875968 16777216

end CS31aData.N13
