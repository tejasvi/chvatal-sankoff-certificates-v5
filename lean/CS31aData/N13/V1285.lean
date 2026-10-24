import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1285 = cert_data/n13/h13c.vec.part1285, entries 123962654720 .. 124059123711, chunks 29555 .. 29577
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1285 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1285" 385875968 16777216

end CS31aData.N13
