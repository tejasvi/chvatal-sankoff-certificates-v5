import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1054 = cert_data/n13/h13c.vec.part1054, entries 101678317568 .. 101774786559, chunks 24242 .. 24264
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1054 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1054" 385875968 16777216

end CS31aData.N13
