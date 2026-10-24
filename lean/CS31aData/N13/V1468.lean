import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1468 = cert_data/n13/h13c.vec.part1468, entries 141616480256 .. 141712949247, chunks 33764 .. 33786
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1468 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1468" 385875968 16777216

end CS31aData.N13
