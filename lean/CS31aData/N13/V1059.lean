import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1059 = cert_data/n13/h13c.vec.part1059, entries 102160662528 .. 102257131519, chunks 24357 .. 24379
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1059 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1059" 385875968 16777216

end CS31aData.N13
