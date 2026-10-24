import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1223 = cert_data/n13/h13c.vec.part1223, entries 117981577216 .. 118078046207, chunks 28129 .. 28151
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1223 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1223" 385875968 16777216

end CS31aData.N13
