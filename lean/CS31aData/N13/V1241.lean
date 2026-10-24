import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1241 = cert_data/n13/h13c.vec.part1241, entries 119718019072 .. 119814488063, chunks 28543 .. 28565
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1241 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1241" 385875968 16777216

end CS31aData.N13
