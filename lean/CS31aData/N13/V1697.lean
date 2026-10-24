import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1697 = cert_data/n13/h13c.vec.part1697, entries 163707879424 .. 163804348415, chunks 39031 .. 39053
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1697 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1697" 385875968 16777216

end CS31aData.N13
