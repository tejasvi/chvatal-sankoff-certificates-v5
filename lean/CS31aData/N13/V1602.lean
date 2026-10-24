import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1602 = cert_data/n13/h13c.vec.part1602, entries 154543325184 .. 154639794175, chunks 36846 .. 36868
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1602 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1602" 385875968 16777216

end CS31aData.N13
