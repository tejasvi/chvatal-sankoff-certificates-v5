import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1543 = cert_data/n13/h13c.vec.part1543, entries 148851654656 .. 148948123647, chunks 35489 .. 35511
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1543 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1543" 385875968 16777216

end CS31aData.N13
