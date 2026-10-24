import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1366 = cert_data/n13/h13c.vec.part1366, entries 131776643072 .. 131873112063, chunks 31418 .. 31440
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1366 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1366" 385875968 16777216

end CS31aData.N13
