import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1689 = cert_data/n13/h13c.vec.part1689, entries 162936127488 .. 163032596479, chunks 38847 .. 38869
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1689 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1689" 385875968 16777216

end CS31aData.N13
