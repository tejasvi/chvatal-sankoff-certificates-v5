import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1338 = cert_data/n13/h13c.vec.part1338, entries 129075511296 .. 129171980287, chunks 30774 .. 30796
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1338 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1338" 385875968 16777216

end CS31aData.N13
