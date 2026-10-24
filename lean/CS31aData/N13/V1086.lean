import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1086 = cert_data/n13/h13c.vec.part1086, entries 104765325312 .. 104861794303, chunks 24978 .. 25000
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1086 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1086" 385875968 16777216

end CS31aData.N13
