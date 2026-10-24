import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1686 = cert_data/n13/h13c.vec.part1686, entries 162646720512 .. 162743189503, chunks 38778 .. 38800
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1686 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1686" 385875968 16777216

end CS31aData.N13
