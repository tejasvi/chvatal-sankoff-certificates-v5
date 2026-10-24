import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1273 = cert_data/n13/h13c.vec.part1273, entries 122805026816 .. 122901495807, chunks 29279 .. 29301
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1273 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1273" 385875968 16777216

end CS31aData.N13
