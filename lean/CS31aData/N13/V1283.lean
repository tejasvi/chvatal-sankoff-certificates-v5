import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1283 = cert_data/n13/h13c.vec.part1283, entries 123769716736 .. 123866185727, chunks 29509 .. 29531
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1283 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1283" 385875968 16777216

end CS31aData.N13
