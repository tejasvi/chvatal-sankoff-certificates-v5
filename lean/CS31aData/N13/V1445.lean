import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1445 = cert_data/n13/h13c.vec.part1445, entries 139397693440 .. 139494162431, chunks 33235 .. 33257
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1445 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1445" 385875968 16777216

end CS31aData.N13
