import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1085 = cert_data/n13/h13c.vec.part1085, entries 104668856320 .. 104765325311, chunks 24955 .. 24977
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1085 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1085" 385875968 16777216

end CS31aData.N13
