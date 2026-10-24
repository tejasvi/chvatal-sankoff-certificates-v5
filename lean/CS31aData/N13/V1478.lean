import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1478 = cert_data/n13/h13c.vec.part1478, entries 142581170176 .. 142677639167, chunks 33994 .. 34016
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1478 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1478" 385875968 16777216

end CS31aData.N13
