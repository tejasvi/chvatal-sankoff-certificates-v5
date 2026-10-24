import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1502 = cert_data/n13/h13c.vec.part1502, entries 144896425984 .. 144992894975, chunks 34546 .. 34568
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1502 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1502" 385875968 16777216

end CS31aData.N13
