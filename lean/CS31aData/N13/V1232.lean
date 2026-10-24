import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1232 = cert_data/n13/h13c.vec.part1232, entries 118849798144 .. 118946267135, chunks 28336 .. 28358
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1232 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1232" 385875968 16777216

end CS31aData.N13
