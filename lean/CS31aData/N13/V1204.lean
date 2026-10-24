import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1204 = cert_data/n13/h13c.vec.part1204, entries 116148666368 .. 116245135359, chunks 27692 .. 27714
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1204 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1204" 385875968 16777216

end CS31aData.N13
