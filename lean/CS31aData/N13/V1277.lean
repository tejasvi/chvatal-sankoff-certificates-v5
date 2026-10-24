import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1277 = cert_data/n13/h13c.vec.part1277, entries 123190902784 .. 123287371775, chunks 29371 .. 29393
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1277 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1277" 385875968 16777216

end CS31aData.N13
