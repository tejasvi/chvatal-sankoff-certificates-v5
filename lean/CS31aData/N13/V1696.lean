import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1696 = cert_data/n13/h13c.vec.part1696, entries 163611410432 .. 163707879423, chunks 39008 .. 39030
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1696 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1696" 385875968 16777216

end CS31aData.N13
