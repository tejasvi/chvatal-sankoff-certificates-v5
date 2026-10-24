import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1367 = cert_data/n13/h13c.vec.part1367, entries 131873112064 .. 131969581055, chunks 31441 .. 31463
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1367 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1367" 385875968 16777216

end CS31aData.N13
