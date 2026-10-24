import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1387 = cert_data/n13/h13c.vec.part1387, entries 133802491904 .. 133898960895, chunks 31901 .. 31923
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1387 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1387" 385875968 16777216

end CS31aData.N13
