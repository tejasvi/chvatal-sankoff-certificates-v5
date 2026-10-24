import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1625 = cert_data/n13/h13c.vec.part1625, entries 156762112000 .. 156858580991, chunks 37375 .. 37397
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1625 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1625" 385875968 16777216

end CS31aData.N13
