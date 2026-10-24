import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1519 = cert_data/n13/h13c.vec.part1519, entries 146536398848 .. 146632867839, chunks 34937 .. 34959
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1519 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1519" 385875968 16777216

end CS31aData.N13
