import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1645 = cert_data/n13/h13c.vec.part1645, entries 158691491840 .. 158787960831, chunks 37835 .. 37857
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1645 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1645" 385875968 16777216

end CS31aData.N13
