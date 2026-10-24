import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1004 = cert_data/n13/h13c.vec.part1004, entries 96854867968 .. 96951336959, chunks 23092 .. 23114
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1004 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1004" 385875968 16777216

end CS31aData.N13
