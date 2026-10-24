import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1110 = cert_data/n13/h13c.vec.part1110, entries 107080581120 .. 107177050111, chunks 25530 .. 25552
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1110 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1110" 385875968 16777216

end CS31aData.N13
