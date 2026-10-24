import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1662 = cert_data/n13/h13c.vec.part1662, entries 160331464704 .. 160427933695, chunks 38226 .. 38248
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1662 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1662" 385875968 16777216

end CS31aData.N13
