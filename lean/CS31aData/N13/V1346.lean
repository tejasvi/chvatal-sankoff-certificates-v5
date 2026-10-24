import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1346 = cert_data/n13/h13c.vec.part1346, entries 129847263232 .. 129943732223, chunks 30958 .. 30980
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1346 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1346" 385875968 16777216

end CS31aData.N13
