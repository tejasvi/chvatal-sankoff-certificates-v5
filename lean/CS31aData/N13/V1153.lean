import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1153 = cert_data/n13/h13c.vec.part1153, entries 111228747776 .. 111325216767, chunks 26519 .. 26541
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1153 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1153" 385875968 16777216

end CS31aData.N13
