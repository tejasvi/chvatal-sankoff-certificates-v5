import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1314 = cert_data/n13/h13c.vec.part1314, entries 126760255488 .. 126856724479, chunks 30222 .. 30244
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1314 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1314" 385875968 16777216

end CS31aData.N13
