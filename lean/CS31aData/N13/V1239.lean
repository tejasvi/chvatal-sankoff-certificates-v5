import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1239 = cert_data/n13/h13c.vec.part1239, entries 119525081088 .. 119621550079, chunks 28497 .. 28519
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1239 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1239" 385875968 16777216

end CS31aData.N13
