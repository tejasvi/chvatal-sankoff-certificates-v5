import CS31aData.Elab

/-! N13 data, vec (binary32 value bits, 4 bytes LE per entry): part 1160 = cert_data/n13/h13c.vec.part1160, entries 111904030720 .. 112000499711, chunks 26680 .. 26702
of 2^22 entries (16777216 bytes). -/

namespace CS31aData.N13

set_option maxHeartbeats 0 in
def v1160 : List (Nat × Nat) :=
  chunks_of_file% "cert_data/n13/h13c.vec.part1160" 385875968 16777216

end CS31aData.N13
