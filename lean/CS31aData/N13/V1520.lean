import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1520 = cert_data/n13/h13c.vec.part1520, entries 146632867840 .. 146729336831, chunks 34960 .. 34982
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1520 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1520" 385875968 16777216

end CS31aData.N13
