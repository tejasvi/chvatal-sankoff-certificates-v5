import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1670 = cert_data/n13/h13c.vec.part1670, entries 161103216640 .. 161199685631, chunks 38410 .. 38432
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1670 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1670" 385875968 16777216

end CS31aData.N13
