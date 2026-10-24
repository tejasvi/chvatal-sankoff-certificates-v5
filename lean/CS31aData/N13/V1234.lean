import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1234 = cert_data/n13/h13c.vec.part1234, entries 119042736128 .. 119139205119, chunks 28382 .. 28404
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1234 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1234" 385875968 16777216

end CS31aData.N13
