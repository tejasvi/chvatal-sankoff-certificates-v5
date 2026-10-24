import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1389 = cert_data/n13/h13c.vec.part1389, entries 133995429888 .. 134091898879, chunks 31947 .. 31969
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1389 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1389" 385875968 16777216

end CS31aData.N13
