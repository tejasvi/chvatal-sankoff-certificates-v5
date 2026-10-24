import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1319 = cert_data/n13/h13c.vec.part1319, entries 127242600448 .. 127339069439, chunks 30337 .. 30359
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1319 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1319" 385875968 16777216

end CS31aData.N13
