import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1681 = cert_data/n13/h13c.vec.part1681, entries 162164375552 .. 162260844543, chunks 38663 .. 38685
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1681 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1681" 385875968 16777216

end CS31aData.N13
