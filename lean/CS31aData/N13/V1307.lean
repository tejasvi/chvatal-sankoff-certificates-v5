import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1307 = cert_data/n13/h13c.vec.part1307, entries 126084972544 .. 126181441535, chunks 30061 .. 30083
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1307 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1307" 385875968 16777216

end CS31aData.N13
