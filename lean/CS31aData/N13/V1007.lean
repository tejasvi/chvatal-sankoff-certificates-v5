import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1007 = cert_data/n13/h13c.vec.part1007, entries 97144274944 .. 97240743935, chunks 23161 .. 23183
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1007 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1007" 385875968 16777216

end CS31aData.N13
