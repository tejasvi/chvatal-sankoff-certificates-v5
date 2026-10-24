import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1642 = cert_data/n13/h13c.vec.part1642, entries 158402084864 .. 158498553855, chunks 37766 .. 37788
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1642 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1642" 385875968 16777216

end CS31aData.N13
