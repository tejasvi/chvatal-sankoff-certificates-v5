import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1208 = cert_data/n13/h13c.vec.part1208, entries 116534542336 .. 116631011327, chunks 27784 .. 27806
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1208 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1208" 385875968 16777216

end CS31aData.N13
