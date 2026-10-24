import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1377 = cert_data/n13/h13c.vec.part1377, entries 132837801984 .. 132934270975, chunks 31671 .. 31693
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1377 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1377" 385875968 16777216

end CS31aData.N13
