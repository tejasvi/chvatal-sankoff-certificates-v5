import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1046 = cert_data/n13/h13c.vec.part1046, entries 100906565632 .. 101003034623, chunks 24058 .. 24080
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1046 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1046" 385875968 16777216

end CS31aData.N13
