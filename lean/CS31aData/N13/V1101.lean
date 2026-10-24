import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1101 = cert_data/n13/h13c.vec.part1101, entries 106212360192 .. 106308829183, chunks 25323 .. 25345
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1101 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1101" 385875968 16777216

end CS31aData.N13
