import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1337 = cert_data/n13/h13c.vec.part1337, entries 128979042304 .. 129075511295, chunks 30751 .. 30773
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1337 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1337" 385875968 16777216

end CS31aData.N13
