import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1327 = cert_data/n13/h13c.vec.part1327, entries 128014352384 .. 128110821375, chunks 30521 .. 30543
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1327 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1327" 385875968 16777216

end CS31aData.N13
